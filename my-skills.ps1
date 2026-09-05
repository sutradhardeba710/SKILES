[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [string]$Command,

    [Parameter(Position = 1)]
    [string]$Arg1,

    [Parameter(Position = 2)]
    [string]$Arg2,

    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$ExtraArgs
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$skillsFile = Join-Path $scriptDir "skills.txt"

if (-not (Test-Path $skillsFile)) {
    Write-Error "skills.txt not found at: $skillsFile"
    exit 1
}

# Subcommand: my-skills edit
if ($Command -eq "edit") {
    Write-Host "Opening skills.txt in Notepad..." -ForegroundColor Cyan
    Start-Process notepad.exe -ArgumentList "`"$skillsFile`"" -Wait
    Write-Host "Syncing changes to GitHub..." -ForegroundColor Yellow
    git -C "$scriptDir" add skills.txt
    git -C "$scriptDir" commit -m "update skills list"
    git -C "$scriptDir" push origin main
    Write-Host "`n[DONE] Master skills updated and pushed to GitHub!`n" -ForegroundColor Green
    exit 0
}

# Subcommand: my-skills list
if ($Command -eq "list") {
    Write-Host "`n==========================================" -ForegroundColor Cyan
    Write-Host "        CURRENT FAVORITE SKILLS" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    Get-Content $skillsFile | Where-Object {
        $t = $_.Trim()
        $t -ne "" -and -not $t.StartsWith("#") -and -not $t.StartsWith(";")
    } | ForEach-Object { Write-Host "  - $_" }
    Write-Host "==========================================`n" -ForegroundColor Cyan
    exit 0
}

# Subcommand: my-skills add [repo] [skill]
if ($Command -eq "add") {
    $repo = $Arg1
    $skillName = $Arg2

    if (-not $repo) {
        Write-Host "`n==========================================" -ForegroundColor Cyan
        Write-Host "             ADD NEW AI SKILL" -ForegroundColor Cyan
        Write-Host "==========================================" -ForegroundColor Cyan
        $repo = Read-Host "Enter GitHub repo URL (e.g. anthropics/skills)"
    }

    if (-not $repo) {
        Write-Error "No repository provided."
        exit 1
    }

    if (-not $skillName) {
        $skillName = Read-Host "Enter skill name (press Enter for all skills)"
    }

    if (-not $skillName) {
        $newEntry = "$repo --skill *"
    } else {
        $newEntry = "$repo --skill $skillName"
    }

    Add-Content -Path $skillsFile -Value $newEntry -Encoding utf8
    Write-Host "`n[SAVED] Added to master list: $newEntry" -ForegroundColor Green

    Write-Host "[GIT] Syncing to GitHub..." -ForegroundColor Yellow
    git -C "$scriptDir" add skills.txt
    git -C "$scriptDir" commit -m "add skill: $newEntry"
    git -C "$scriptDir" push origin main

    Write-Host "`n[INSTALLING] Installing $newEntry to current project..." -ForegroundColor Green
    $cmdParts = $newEntry -split "\s+"
    $argsList = @("--yes", "skills", "add") + $cmdParts + @("--agent", "antigravity", "--copy", "-y")
    & npx.cmd @argsList

    Write-Host "`n==========================================" -ForegroundColor Cyan
    Write-Host "   DONE! SAVED, PUSHED & INSTALLED!" -ForegroundColor Cyan
    Write-Host "==========================================`n" -ForegroundColor Cyan
    exit 0
}

# Normal install flow
Write-Host "`n==========================================" -ForegroundColor Cyan
Write-Host "       AI SKILLS INSTALLER (SKILES)" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "Working Directory: $(Get-Location)" -ForegroundColor Gray

$allPassed = @()
if ($Command) { $allPassed += $Command }
if ($Arg1) { $allPassed += $Arg1 }
if ($Arg2) { $allPassed += $Arg2 }
if ($ExtraArgs) { $allPassed += $ExtraArgs }

$hasAgentArg = ($allPassed -join " ") -match "(--agent|-a)\b"
$defaultAgentArgs = @()
if (-not $hasAgentArg) {
    $defaultAgentArgs = @("--agent", "antigravity")
    Write-Host "Target Folder: .agents\skills\ (Universal)" -ForegroundColor Gray
}

Write-Host "Mode: Full physical copy (--copy)`n" -ForegroundColor Gray

$lines = Get-Content $skillsFile | Where-Object {
    $trimmed = $_.Trim()
    $trimmed -ne "" -and -not $trimmed.StartsWith("#") -and -not $trimmed.StartsWith(";")
}

foreach ($line in $lines) {
    Write-Host "[INSTALLING] $line $allPassed" -ForegroundColor Green
    $cmdParts = $line -split "\s+"
    $argsList = @("--yes", "skills", "add") + $cmdParts + $defaultAgentArgs + @("--copy") + $allPassed + @("-y")
    & npx.cmd @argsList
}

Write-Host "`n==========================================" -ForegroundColor Cyan
Write-Host "      ALL FAVORITE SKILLS INSTALLED" -ForegroundColor Cyan
Write-Host "==========================================`n" -ForegroundColor Cyan