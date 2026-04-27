$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$backendDir = Join-Path $projectRoot "Airport-System-Management-main\Airport-System-Management-main\backendhehehehehee\airport-management"
$mvnw = Join-Path $backendDir "mvnw.cmd"
$frontendPom = Join-Path $projectRoot "pom.xml"
$logDir = Join-Path $projectRoot "target\run-logs"
$backendOut = Join-Path $logDir "backend.out.log"
$backendErr = Join-Path $logDir "backend.err.log"
$backendPort = 8080

function Test-TcpPort {
    param([int] $Port)

    $client = New-Object System.Net.Sockets.TcpClient
    try {
        $client.Connect("127.0.0.1", $Port)
        return $true
    } catch {
        return $false
    } finally {
        $client.Close()
    }
}

function Wait-Backend {
    param(
        [int] $Port,
        [int] $TimeoutSeconds
    )

    $deadline = (Get-Date).AddSeconds($TimeoutSeconds)
    while ((Get-Date) -lt $deadline) {
        if (Test-TcpPort -Port $Port) {
            return $true
        }
        Start-Sleep -Seconds 2
    }
    return $false
}

function Get-PortProcessIds {
    param([int] $Port)

    $listeners = netstat -ano | Select-String ":$Port\s+.*LISTENING"
    $ids = @()
    foreach ($listener in $listeners) {
        $parts = ($listener.Line -split "\s+") | Where-Object { $_ }
        if ($parts.Length -gt 0) {
            $ids += [int] $parts[$parts.Length - 1]
        }
    }
    return $ids | Select-Object -Unique
}

function Show-LogTail {
    param([string] $Path)

    if (Test-Path $Path) {
        Write-Host ""
        Write-Host "Log: $Path" -ForegroundColor Yellow
        Get-Content $Path -Tail 60
    }
}

function Test-ProjectBackendProcess {
    param(
        [int] $ProcessId,
        [string] $BackendDirectory
    )

    $processInfo = Get-CimInstance Win32_Process -Filter "ProcessId = $ProcessId" -ErrorAction SilentlyContinue
    if (-not $processInfo) {
        return $false
    }
    return ($processInfo.CommandLine -like "*$BackendDirectory*") -or
        ($processInfo.CommandLine -like "*AirportManagementApplication*")
}

function Stop-BackendProcesses {
    param([string] $BackendDirectory)

    if ($backendProcess -and -not $backendProcess.HasExited) {
        & taskkill /PID $backendProcess.Id /T /F | Out-Null
    }

    Get-CimInstance Win32_Process |
        Where-Object {
            ($_.ProcessId -ne $PID) -and (
                ($_.CommandLine -like "*$BackendDirectory*") -or
                ($_.CommandLine -like "*AirportManagementApplication*")
            )
        } |
        ForEach-Object {
            Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue
        }
}

if (-not (Test-Path $mvnw)) {
    Write-Host "Khong tim thay Maven Wrapper backend: $mvnw" -ForegroundColor Red
    Read-Host "Nhan Enter de thoat"
    exit 1
}

if (-not (Test-Path $frontendPom)) {
    Write-Host "Khong tim thay pom.xml frontend: $frontendPom" -ForegroundColor Red
    Read-Host "Nhan Enter de thoat"
    exit 1
}

New-Item -ItemType Directory -Force -Path $logDir | Out-Null

$backendProcess = $null
$startedBackend = $false
$frontendExitCode = 0

try {
    Set-Location $projectRoot

    if (Test-TcpPort -Port $backendPort) {
        $portProcessIds = @(Get-PortProcessIds -Port $backendPort)
        $projectBackendOnPort = $portProcessIds | Where-Object { Test-ProjectBackendProcess -ProcessId $_ -BackendDirectory $backendDir }
        if ($projectBackendOnPort) {
            Write-Host "Dang tat backend cu cua project tren port $backendPort..." -ForegroundColor Yellow
            Stop-BackendProcesses -BackendDirectory $backendDir
            Start-Sleep -Seconds 2
        } else {
            Write-Host "Port $backendPort dang duoc su dung boi process khac: $($portProcessIds -join ', ')." -ForegroundColor Red
            Write-Host "Hay tat process do hoac doi server.port truoc khi chay lai." -ForegroundColor Red
            Read-Host "Nhan Enter de thoat"
            exit 1
        }
    }

    Write-Host "Dang khoi dong backend Spring Boot..." -ForegroundColor Cyan
    $backendProcess = Start-Process `
        -FilePath $mvnw `
        -ArgumentList @("spring-boot:run") `
        -WorkingDirectory $backendDir `
        -WindowStyle Hidden `
        -RedirectStandardOutput $backendOut `
        -RedirectStandardError $backendErr `
        -PassThru
    $startedBackend = $true

    if (-not (Wait-Backend -Port $backendPort -TimeoutSeconds 90)) {
        Write-Host "Backend khong san sang tren port $backendPort." -ForegroundColor Red
        Show-LogTail -Path $backendOut
        Show-LogTail -Path $backendErr
        Read-Host "Nhan Enter de thoat"
        exit 1
    }

    Write-Host "Dang mo frontend JavaFX..." -ForegroundColor Green
    & $mvnw -f $frontendPom javafx:run
    $frontendExitCode = $LASTEXITCODE
} catch {
    Write-Host $_.Exception.Message -ForegroundColor Red
    Show-LogTail -Path $backendOut
    Show-LogTail -Path $backendErr
    Read-Host "Nhan Enter de thoat"
    exit 1
} finally {
    if ($startedBackend) {
        Write-Host "Dang tat backend..." -ForegroundColor Cyan
        Stop-BackendProcesses -BackendDirectory $backendDir
    }
}

if ($frontendExitCode -ne 0) {
    Write-Host "Frontend dong voi ma loi $frontendExitCode." -ForegroundColor Red
    Read-Host "Nhan Enter de thoat"
    exit $frontendExitCode
}
