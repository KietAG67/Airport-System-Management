param(
    [ValidateSet("small", "large")]
    [string]$Dataset = "large",

    [string]$SqlPath = "",

    [string]$BaseUrl = "http://localhost:8080/api",

    [string]$Username = "admin@airport.com",

    [string]$Password = "123456",

    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

function Resolve-ImportSqlPath {
    if (-not [string]::IsNullOrWhiteSpace($SqlPath)) {
        return (Resolve-Path -LiteralPath $SqlPath).Path
    }

    $fileName = if ($Dataset -eq "large") { "tsn_data_large.sql" } else { "tsn_data.sql" }
    return (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "database\$fileName")).Path
}

function Remove-SqlLineComments {
    param([string]$Text)

    $result = New-Object System.Text.StringBuilder
    foreach ($line in ($Text -split "`r?`n")) {
        $inString = $false
        $i = 0
        while ($i -lt $line.Length) {
            $ch = $line[$i]
            if ($ch -eq "'") {
                if ($inString -and $i + 1 -lt $line.Length -and $line[$i + 1] -eq "'") {
                    [void]$result.Append("''")
                    $i += 2
                    continue
                }
                $inString = -not $inString
            }
            if (-not $inString -and $ch -eq "-" -and $i + 1 -lt $line.Length -and $line[$i + 1] -eq "-") {
                break
            }
            [void]$result.Append($ch)
            $i++
        }
        [void]$result.AppendLine()
    }
    return $result.ToString()
}

function Convert-SqlValue {
    param([string]$Value)

    $trimmed = $Value.Trim()
    if ($trimmed -match "^(?i)null$") {
        return $null
    }
    if ($trimmed.Length -ge 2 -and $trimmed[0] -eq "'" -and $trimmed[$trimmed.Length - 1] -eq "'") {
        return $trimmed.Substring(1, $trimmed.Length - 2).Replace("''", "'")
    }
    return $trimmed
}

function Split-SqlTupleFields {
    param([string]$Tuple)

    $fields = New-Object System.Collections.Generic.List[string]
    $buffer = New-Object System.Text.StringBuilder
    $inString = $false
    $i = 0
    while ($i -lt $Tuple.Length) {
        $ch = $Tuple[$i]
        if ($ch -eq "'") {
            if ($inString -and $i + 1 -lt $Tuple.Length -and $Tuple[$i + 1] -eq "'") {
                [void]$buffer.Append("''")
                $i += 2
                continue
            }
            $inString = -not $inString
        }

        if (-not $inString -and $ch -eq ",") {
            $fields.Add($buffer.ToString())
            [void]$buffer.Clear()
        } else {
            [void]$buffer.Append($ch)
        }
        $i++
    }
    $fields.Add($buffer.ToString())

    $values = @()
    foreach ($field in $fields) {
        $values += ,(Convert-SqlValue $field)
    }
    return ,$values
}

function Get-SqlTuples {
    param([string]$ValuesText)

    $tuples = New-Object System.Collections.Generic.List[object]
    $buffer = New-Object System.Text.StringBuilder
    $inString = $false
    $depth = 0
    $i = 0
    while ($i -lt $ValuesText.Length) {
        $ch = $ValuesText[$i]
        if ($ch -eq "'") {
            if ($inString -and $i + 1 -lt $ValuesText.Length -and $ValuesText[$i + 1] -eq "'") {
                if ($depth -gt 0) {
                    [void]$buffer.Append("''")
                }
                $i += 2
                continue
            }
            $inString = -not $inString
        }

        if (-not $inString -and $ch -eq "(") {
            if ($depth -eq 0) {
                [void]$buffer.Clear()
            } else {
                [void]$buffer.Append($ch)
            }
            $depth++
        } elseif (-not $inString -and $ch -eq ")") {
            $depth--
            if ($depth -eq 0) {
                $tuples.Add((Split-SqlTupleFields $buffer.ToString()))
                [void]$buffer.Clear()
            } elseif ($depth -gt 0) {
                [void]$buffer.Append($ch)
            }
        } elseif ($depth -gt 0) {
            [void]$buffer.Append($ch)
        }
        $i++
    }
    return $tuples
}

function Read-InsertTables {
    param([string]$Path)

    $sql = Get-Content -LiteralPath $Path -Raw -Encoding UTF8
    $cleanSql = Remove-SqlLineComments $sql
    $tables = @{}
    $pattern = "(?is)INSERT\s+INTO\s+([A-Za-z_]+)(?:\s*\([^)]+\))?\s+VALUES\s+(.*?);"
    foreach ($match in [regex]::Matches($cleanSql, $pattern)) {
        $tableName = $match.Groups[1].Value
        if (-not $tables.ContainsKey($tableName)) {
            $tables[$tableName] = New-Object System.Collections.Generic.List[object]
        }
        foreach ($tuple in (Get-SqlTuples $match.Groups[2].Value)) {
            $tables[$tableName].Add($tuple)
        }
    }
    return $tables
}

function Convert-ToIsoDateTime {
    param([object]$Value)

    if ($null -eq $Value -or [string]::IsNullOrWhiteSpace([string]$Value)) {
        return $null
    }
    return ([datetime]::ParseExact([string]$Value, "yyyy-MM-dd HH:mm:ss", [Globalization.CultureInfo]::InvariantCulture)).ToString("yyyy-MM-ddTHH:mm:ss")
}

function Convert-ToIsoDate {
    param([object]$Value)

    if ($null -eq $Value -or [string]::IsNullOrWhiteSpace([string]$Value)) {
        return $null
    }
    return ([datetime]::ParseExact([string]$Value, "yyyy-MM-dd", [Globalization.CultureInfo]::InvariantCulture)).ToString("yyyy-MM-dd")
}

function Get-DatePart {
    param([object]$Value)

    if ($null -eq $Value) { return $null }
    return ([datetime]::ParseExact([string]$Value, "yyyy-MM-dd HH:mm:ss", [Globalization.CultureInfo]::InvariantCulture)).ToString("yyyy-MM-dd")
}

function Get-TimePart {
    param([object]$Value)

    if ($null -eq $Value) { return $null }
    return ([datetime]::ParseExact([string]$Value, "yyyy-MM-dd HH:mm:ss", [Globalization.CultureInfo]::InvariantCulture)).ToString("HH:mm:ss")
}

function Join-NameParts {
    param([object[]]$Parts)

    return (($Parts | Where-Object { $null -ne $_ -and -not [string]::IsNullOrWhiteSpace([string]$_) }) -join " ").Trim()
}

function Convert-FlightStatus {
    param([string]$Status)

    switch -Regex ($Status) {
        "^(?i)completed$" { return "ARRIVED" }
        "^(?i)cancelled$" { return "CANCELLED" }
        "^(?i)scheduled$" { return "ON_TIME" }
        "^(?i)delayed$" { return "DELAYED" }
        default { return "ON_TIME" }
    }
}

function Convert-SeatClass {
    param([string]$SeatClass)

    switch -Regex ($SeatClass) {
        "^(?i)business$" { return "BUSINESS" }
        "^(?i)first$" { return "FIRST" }
        default { return "ECONOMY" }
    }
}

function Convert-LuggageStatus {
    param([string]$Status)

    switch -Regex ($Status) {
        "^(?i)delivered$" { return "DELIVERED" }
        "^(?i)lost$" { return "LOST" }
        "^(?i)loaded$" { return "LOADED" }
        "^(?i)delayed$" { return "IN_TRANSIT" }
        "^(?i)in[_ -]?transit$" { return "IN_TRANSIT" }
        default { return "CHECKED_IN" }
    }
}

function Convert-SecurityResult {
    param([string]$Result)

    switch -Regex ($Result) {
        "^(?i)clear(ed)?$" { return "CLEARED" }
        "^(?i)reject(ed)?$" { return "REJECTED" }
        default { return "FLAGGED" }
    }
}

function ConvertTo-ApiJson {
    param([hashtable]$Body)

    return ($Body | ConvertTo-Json -Depth 20)
}

function Invoke-Api {
    param(
        [string]$Method,
        [string]$Path,
        [hashtable]$Body = $null
    )

    $params = @{
        Method  = $Method
        Uri     = "$BaseUrl$Path"
        Headers = $script:Headers
    }
    if ($null -ne $Body) {
        $params["ContentType"] = "application/json; charset=utf-8"
        $params["Body"] = [System.Text.Encoding]::UTF8.GetBytes((ConvertTo-ApiJson $Body))
    }
    try {
        return Invoke-RestMethod @params
    } catch {
        $statusCode = $null
        if ($_.Exception.Response -and $_.Exception.Response.StatusCode) {
            $statusCode = [int]$_.Exception.Response.StatusCode
        }
        $statusText = if ($null -ne $statusCode) { " HTTP $statusCode." } else { "" }
        throw "API $Method $Path failed.$statusText $($_.Exception.Message)"
    }
}

function Get-IndexByProperty {
    param(
        [object[]]$Items,
        [string]$Property
    )

    $index = @{}
    function Add-IndexItem {
        param([object]$Item)

        if ($null -eq $Item) {
            return
        }
        if ($Item -is [System.Array]) {
            foreach ($child in $Item) {
                Add-IndexItem $child
            }
            return
        }
        if ($null -ne $Item.$Property -and -not [string]::IsNullOrWhiteSpace([string]$Item.$Property)) {
            $index[([string]$Item.$Property).Trim().ToUpperInvariant()] = $Item
        }
    }

    foreach ($item in @($Items)) {
        Add-IndexItem $item
    }
    return $index
}

function Save-Entity {
    param(
        [string]$Endpoint,
        [string]$UidProperty,
        [hashtable]$Payload,
        [hashtable]$Index,
        [hashtable]$StatsKey
    )

    $uid = ([string]$Payload[$UidProperty]).Trim()
    $indexKey = $uid.ToUpperInvariant()
    if ([string]::IsNullOrWhiteSpace($uid)) {
        throw "Missing uid property $UidProperty for endpoint $Endpoint."
    }

    if ($DryRun) {
        if ($Index.ContainsKey($indexKey)) {
            $script:Stats[$StatsKey.updated]++
        } else {
            $Payload["id"] = $Index.Count + 1
            $Index[$indexKey] = [pscustomobject]$Payload
            $script:Stats[$StatsKey.created]++
        }
        return $Index[$indexKey]
    }

    if ($Index.ContainsKey($indexKey)) {
        $id = $Index[$indexKey].id
        $Payload["id"] = $id
        $saved = Invoke-Api -Method "PUT" -Path "$Endpoint/$id" -Body $Payload
        $Index[$indexKey] = $saved
        $script:Stats[$StatsKey.updated]++
        return $saved
    }

    $saved = Invoke-Api -Method "POST" -Path $Endpoint -Body $Payload
    $Index[$indexKey] = $saved
    $script:Stats[$StatsKey.created]++
    return $saved
}

function Require-Table {
    param(
        [hashtable]$Tables,
        [string]$Name
    )

    if ($Tables.ContainsKey($Name)) {
        return @($Tables[$Name].ToArray())
    }
    return @()
}

$resolvedSqlPath = Resolve-ImportSqlPath
Write-Host "Import source: $resolvedSqlPath"
Write-Host "Backend API: $BaseUrl"

$tables = Read-InsertTables $resolvedSqlPath
Write-Host "Parsed tables:"
foreach ($key in ($tables.Keys | Sort-Object)) {
    Write-Host ("  {0}: {1}" -f $key, $tables[$key].Count)
}

if ($DryRun) {
    Write-Host "Dry run enabled: no API writes will be performed."
} else {
    try {
        $loginBody = @{ username = $Username; password = $Password } | ConvertTo-Json
        $auth = Invoke-RestMethod -Method "POST" -Uri "$BaseUrl/auth/login" -ContentType "application/json; charset=utf-8" -Body $loginBody
        if ([string]::IsNullOrWhiteSpace($auth.token)) {
            throw "Login response did not contain a JWT token."
        }
        $script:Headers = @{ Authorization = "Bearer $($auth.token)" }
    } catch {
        throw "Cannot login to backend. Make sure run-app.bat is running and the admin account is valid. Detail: $($_.Exception.Message)"
    }
}

$script:Stats = @{
    employeesCreated       = 0
    employeesUpdated       = 0
    passengersCreated      = 0
    passengersUpdated      = 0
    flightsCreated         = 0
    flightsUpdated         = 0
    ticketsCreated         = 0
    ticketsUpdated         = 0
    boardingPassesCreated  = 0
    boardingPassesUpdated  = 0
    luggagesCreated        = 0
    luggagesUpdated        = 0
    securityLogsCreated    = 0
    securityLogsUpdated    = 0
    skipped                = 0
}

if ($DryRun) {
    $employeeIndex = @{}
    $passengerIndex = @{}
    $flightIndex = @{}
    $ticketIndex = @{}
    $boardingPassIndex = @{}
    $luggageIndex = @{}
    $securityLogIndex = @{}
} else {
    $employeeIndex = Get-IndexByProperty -Items @(Invoke-Api -Method "GET" -Path "/employees") -Property "employeeUid"
    $passengerIndex = Get-IndexByProperty -Items @(Invoke-Api -Method "GET" -Path "/passengers") -Property "passengerUid"
    $flightIndex = Get-IndexByProperty -Items @(Invoke-Api -Method "GET" -Path "/flights") -Property "flightUid"
    $ticketIndex = Get-IndexByProperty -Items @(Invoke-Api -Method "GET" -Path "/tickets") -Property "ticketUid"
    $boardingPassIndex = Get-IndexByProperty -Items @(Invoke-Api -Method "GET" -Path "/boarding-passes") -Property "boardingPassUid"
    $luggageIndex = Get-IndexByProperty -Items @(Invoke-Api -Method "GET" -Path "/luggages") -Property "luggageUid"
    $securityLogIndex = Get-IndexByProperty -Items @(Invoke-Api -Method "GET" -Path "/security-logs") -Property "logUid"
    Write-Host ("Existing API records: employees={0}, passengers={1}, flights={2}, tickets={3}, boardingPasses={4}, luggages={5}, securityLogs={6}" -f `
        $employeeIndex.Count, $passengerIndex.Count, $flightIndex.Count, $ticketIndex.Count, $boardingPassIndex.Count, $luggageIndex.Count, $securityLogIndex.Count)
}

$aircraftById = @{}
foreach ($row in (Require-Table $tables "Aircraft")) {
    $aircraftById[[string]$row[0]] = [string]$row[1]
}

$emailByPassenger = @{}
foreach ($row in (Require-Table $tables "Passenger_Email")) {
    if ($null -ne $row[0] -and $null -ne $row[1]) {
        $emailByPassenger[[string]$row[0]] = [string]$row[1]
    }
}

$phoneByPassenger = @{}
foreach ($row in (Require-Table $tables "Passenger_Phone")) {
    if ($null -ne $row[0] -and $null -ne $row[1]) {
        $phoneByPassenger[[string]$row[0]] = [string]$row[1]
    }
}

foreach ($row in (Require-Table $tables "Employee")) {
    $employeeUid = [string]$row[0]
    $payload = @{
        employeeUid = $employeeUid
        fullName    = [string]$row[1]
        email       = ("{0}@tsn.local" -f $employeeUid.ToLowerInvariant())
        phone       = ""
        department  = [string]$row[3]
        jobTitle    = [string]$row[2]
    }
    [void](Save-Entity "/employees" "employeeUid" $payload $employeeIndex @{ created = "employeesCreated"; updated = "employeesUpdated" })
}

foreach ($row in (Require-Table $tables "Passenger")) {
    $passengerUid = [string]$row[0]
    $payload = @{
        passengerUid    = $passengerUid
        fullName        = (Join-NameParts @($row[1], $row[2], $row[3]))
        passportNumber  = $passengerUid
        email           = if ($emailByPassenger.ContainsKey($passengerUid)) { $emailByPassenger[$passengerUid] } else { "" }
        phone           = if ($phoneByPassenger.ContainsKey($passengerUid)) { $phoneByPassenger[$passengerUid] } else { "" }
        dateOfBirth     = Convert-ToIsoDate $row[4]
        nationality     = [string]$row[5]
    }
    [void](Save-Entity "/passengers" "passengerUid" $payload $passengerIndex @{ created = "passengersCreated"; updated = "passengersUpdated" })
}

foreach ($row in (Require-Table $tables "Flight")) {
    $flightUid = [string]$row[0]
    $aircraftId = [string]$row[9]
    $payload = @{
        flightUid        = $flightUid
        flightNumber     = [string]$row[1]
        aircraft         = if ($aircraftById.ContainsKey($aircraftId)) { $aircraftById[$aircraftId] } else { $aircraftId }
        departureAirport = [string]$row[2]
        arrivalAirport   = [string]$row[3]
        departureTime    = Convert-ToIsoDateTime $row[4]
        actualDeparture  = Convert-ToIsoDateTime $row[5]
        arrivalTime      = Convert-ToIsoDateTime $row[6]
        actualArrival    = Convert-ToIsoDateTime $row[7]
        status           = Convert-FlightStatus ([string]$row[8])
    }
    [void](Save-Entity "/flights" "flightUid" $payload $flightIndex @{ created = "flightsCreated"; updated = "flightsUpdated" })
}

foreach ($row in (Require-Table $tables "Ticket")) {
    $ticketUid = [string]$row[0]
    $passengerUid = [string]$row[6]
    $flightUid = [string]$row[7]
    $passengerKey = $passengerUid.Trim().ToUpperInvariant()
    $flightKey = $flightUid.Trim().ToUpperInvariant()
    if (-not $passengerIndex.ContainsKey($passengerKey) -or -not $flightIndex.ContainsKey($flightKey)) {
        Write-Warning "Skip ticket $ticketUid because passenger or flight is missing."
        $script:Stats.skipped++
        continue
    }

    $payload = @{
        ticketUid    = $ticketUid
        passenger    = @{ id = $passengerIndex[$passengerKey].id }
        flight       = @{ id = $flightIndex[$flightKey].id }
        seatNumber   = [string]$row[2]
        seatClass    = Convert-SeatClass ([string]$row[3])
        price        = [decimal]$row[4]
        purchaseDate = Convert-ToIsoDateTime $row[5]
        status       = "BOOKED"
    }
    [void](Save-Entity "/tickets" "ticketUid" $payload $ticketIndex @{ created = "ticketsCreated"; updated = "ticketsUpdated" })
}

foreach ($row in (Require-Table $tables "Boarding_Pass")) {
    $boardingPassUid = [string]$row[0]
    $ticketUid = [string]$row[1]
    $ticketKey = $ticketUid.Trim().ToUpperInvariant()
    if (-not $ticketIndex.ContainsKey($ticketKey)) {
        Write-Warning "Skip boarding pass $boardingPassUid because ticket $ticketUid is missing."
        $script:Stats.skipped++
        continue
    }

    $payload = @{
        boardingPassUid = $boardingPassUid
        ticket          = @{ id = $ticketIndex[$ticketKey].id }
        gate            = [string]$row[3]
        boardingTime    = Convert-ToIsoDateTime $row[2]
        status          = "ISSUED"
    }
    [void](Save-Entity "/boarding-passes" "boardingPassUid" $payload $boardingPassIndex @{ created = "boardingPassesCreated"; updated = "boardingPassesUpdated" })
}

foreach ($row in (Require-Table $tables "Luggage")) {
    $luggageUid = [string]$row[0]
    $ticketUid = [string]$row[4]
    $ticketKey = $ticketUid.Trim().ToUpperInvariant()
    if (-not $ticketIndex.ContainsKey($ticketKey)) {
        Write-Warning "Skip luggage $luggageUid because ticket $ticketUid is missing."
        $script:Stats.skipped++
        continue
    }

    $payload = @{
        luggageUid    = $luggageUid
        ticket        = @{ id = $ticketIndex[$ticketKey].id }
        weight        = [double]$row[1]
        status        = Convert-LuggageStatus ([string]$row[3])
        checkedInTime = Convert-ToIsoDateTime $row[2]
    }
    [void](Save-Entity "/luggages" "luggageUid" $payload $luggageIndex @{ created = "luggagesCreated"; updated = "luggagesUpdated" })
}

$securityLogNumber = 1
foreach ($row in (Require-Table $tables "Security_Log")) {
    $passengerUid = [string]$row[0]
    $passengerKey = $passengerUid.Trim().ToUpperInvariant()
    if (-not $passengerIndex.ContainsKey($passengerKey)) {
        Write-Warning "Skip security log for $passengerUid because passenger is missing."
        $script:Stats.skipped++
        continue
    }

    $stamp = ([datetime]::ParseExact([string]$row[1], "yyyy-MM-dd HH:mm:ss", [Globalization.CultureInfo]::InvariantCulture)).ToString("yyyyMMddHHmmss")
    $payload = @{
        logUid        = "SEC-$passengerUid-$stamp"
        passenger     = @{ id = $passengerIndex[$passengerKey].id }
        employee      = $null
        screeningDate = Get-DatePart $row[1]
        screeningTime = Get-TimePart $row[1]
        result        = Convert-SecurityResult ([string]$row[2])
        notes         = if ($null -ne $row[3]) { [string]$row[3] } else { "" }
    }
    [void](Save-Entity "/security-logs" "logUid" $payload $securityLogIndex @{ created = "securityLogsCreated"; updated = "securityLogsUpdated" })
    $securityLogNumber++
}

Write-Host ""
Write-Host "Import summary:"
foreach ($key in ($script:Stats.Keys | Sort-Object)) {
    Write-Host ("  {0}: {1}" -f $key, $script:Stats[$key])
}

Write-Host ""
Write-Host "Ignored source tables: Crew_Flight, Security_Restricted_Items."
Write-Host "Reason: current backend/frontend has no matching entity screens for those tables."
