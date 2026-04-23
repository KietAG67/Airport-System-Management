$ErrorActionPreference = "Stop"

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $projectRoot

$javafxVersion = "21.0.2"
$javafxRepo = Join-Path $env:USERPROFILE ".m2\repository\org\openjfx"
$javafxJars = @(
    (Join-Path $javafxRepo "javafx-base\$javafxVersion\javafx-base-$javafxVersion-win.jar"),
    (Join-Path $javafxRepo "javafx-graphics\$javafxVersion\javafx-graphics-$javafxVersion-win.jar"),
    (Join-Path $javafxRepo "javafx-controls\$javafxVersion\javafx-controls-$javafxVersion-win.jar")
)

$missingJars = $javafxJars | Where-Object { -not (Test-Path $_) }
if ($missingJars) {
    Write-Host "Khong tim thay thu vien JavaFX can thiet:" -ForegroundColor Red
    $missingJars | ForEach-Object { Write-Host " - $_" -ForegroundColor Red }
    Write-Host ""
    Write-Host "Neu ban mo project bang IntelliJ, co the chay Maven tool window > Plugins > javafx > javafx:run." -ForegroundColor Yellow
    Read-Host "Nhan Enter de thoat"
    exit 1
}

$javacCommand = Get-Command javac -ErrorAction SilentlyContinue
if (-not $javacCommand) {
    Write-Host "Khong tim thay javac. Hay cai JDK day du hoac mo project trong IntelliJ." -ForegroundColor Red
    Read-Host "Nhan Enter de thoat"
    exit 1
}

$sourceDir = Join-Path $projectRoot "src\main\java"
$resourceDir = Join-Path $projectRoot "src\main\resources"
$outputDir = Join-Path $projectRoot "target\manual-classes"

New-Item -ItemType Directory -Force -Path $outputDir | Out-Null

$javaFiles = Get-ChildItem $sourceDir -Recurse -Filter *.java | Select-Object -ExpandProperty FullName
if (-not $javaFiles) {
    Write-Host "Khong tim thay file .java trong src\\main\\java." -ForegroundColor Red
    Read-Host "Nhan Enter de thoat"
    exit 1
}

$modulePath = $javafxJars -join ";"

Write-Host "Dang compile ung dung..." -ForegroundColor Cyan
& $javacCommand.Source --module-path $modulePath --add-modules javafx.controls -encoding UTF-8 -d $outputDir $javaFiles
if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Read-Host "Compile loi. Nhan Enter de thoat"
    exit $LASTEXITCODE
}

if (Test-Path $resourceDir) {
    Copy-Item (Join-Path $resourceDir "*") $outputDir -Recurse -Force
}

Write-Host "Dang mo giao dien..." -ForegroundColor Green
& java --module-path $modulePath --add-modules javafx.controls -cp $outputDir com.airport.AirportManagementApp
$exitCode = $LASTEXITCODE

if ($exitCode -ne 0) {
    Write-Host ""
    Read-Host "Ung dung dong voi loi. Nhan Enter de thoat"
    exit $exitCode
}
