[CmdletBinding()]
param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$ExtraArgs
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$skillsFile = Join-Path $scriptDir "skills.txt"

Write-Host "`n==========================================" -ForegroundColor Cyan
Write-Host "       AI SKILLS INSTALLER (SKILES)" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "Working Directory: $(Get-Location)`n" -ForegroundColor Gray

if (-not (Test-Path $skillsFile)) {
    Write-Error "skills.txt not found at: $skillsFile"
    exit 1
}

$lines = Get-Content $skillsFile | Where-Object {
    $trimmed = $_.Trim()
    $trimmed -ne "" -and -not $trimmed.StartsWith("#") -and -not $trimmed.StartsWith(";")
}

foreach ($line in $lines) {
    Write-Host "[INSTALLING] $line $ExtraArgs" -ForegroundColor Green
    $cmdParts = $line -split "\s+"
    $argsList = @("--yes", "skills", "add") + $cmdParts + $ExtraArgs + @("-y")
    & npx.cmd @argsList
}

Write-Host "`n==========================================" -ForegroundColor Cyan
Write-Host "      ALL FAVORITE SKILLS INSTALLED" -ForegroundColor Cyan
Write-Host "==========================================`n" -ForegroundColor Cyan
