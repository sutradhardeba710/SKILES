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

# Complete 20 AI Video Director Suite
$videoSkills = @(
    "videoprompt",
    "video-hook-director",
    "cinematography",
    "storytelling",
    "project-continuity",
    "character-design",
    "commercial",
    "fal-gamedev",
    "fal-models-catalog",
    "fal-prompting",
    "fal-recipes",
    "fal-redesign",
    "fal-regenerate-3d",
    "fal-workflow",
    "fan-cam",
    "genmedia",
    "genmedia-workflow",
    "marketing",
    "model-routing",
    "ugc"
)

function Install-VideoSkillsSuite {
    param(
        [string]$TargetDir = (Get-Location).Path
    )

    Write-Host ""
    Write-Host "========================================================" -ForegroundColor Cyan
    Write-Host "   VIDEOPROMPT SUITE - 1-CLICK INSTALLER               " -ForegroundColor Cyan
    Write-Host "   (20 Cinematic AI Director & Video Prompt Skills)     " -ForegroundColor Cyan
    Write-Host "========================================================" -ForegroundColor Cyan
    Write-Host "Target Directory: $TargetDir" -ForegroundColor Gray

    $agentsDest = Join-Path $TargetDir ".agents\skills"
    $claudeDest = Join-Path $TargetDir ".claude\skills"

    if (-not (Test-Path $agentsDest)) { New-Item -ItemType Directory -Path $agentsDest -Force | Out-Null }
    if (-not (Test-Path $claudeDest)) { New-Item -ItemType Directory -Path $claudeDest -Force | Out-Null }

    $installedCount = 0
    foreach ($s in $videoSkills) {
        $sourcePath = Join-Path $scriptDir $s
        if (-not (Test-Path $sourcePath)) {
            $fallback = "C:\Users\deba_pc.com\OneDrive\Desktop\skiles\$s"
            if (Test-Path $fallback) { $sourcePath = $fallback }
        }

        if (Test-Path $sourcePath) {
            $destA = Join-Path $agentsDest $s
            $destC = Join-Path $claudeDest $s
            Copy-Item -Path $sourcePath -Destination $destA -Recurse -Force
            Copy-Item -Path $sourcePath -Destination $destC -Recurse -Force
            Write-Host "  [OK] Installed $s" -ForegroundColor Green
            $installedCount++
        } else {
            Write-Host "  [NPX] Downloading $s from GitHub..." -ForegroundColor Yellow
            & npx.cmd --yes skills add "https://github.com/sutradhardeba710/SKILES" --skill $s --agent antigravity --copy -y
            $installedCount++
        }
    }

    Write-Host ""
    Write-Host "========================================================" -ForegroundColor Cyan
    Write-Host "  ALL $installedCount VIDEO PROMPT SKILLS INSTALLED IN 1 CLICK!" -ForegroundColor Green
    Write-Host "  Locations:" -ForegroundColor Gray
    Write-Host "    - $agentsDest" -ForegroundColor DarkCyan
    Write-Host "    - $claudeDest" -ForegroundColor DarkCyan
    Write-Host "========================================================" -ForegroundColor Cyan
    Write-Host ""
}

# Subcommand: videoprompt / video
if ($Command -eq "videoprompt" -or $Command -eq "video" -or $Command -eq "videoprompts") {
    Install-VideoSkillsSuite -TargetDir (Get-Location).Path
    exit 0
}

# Subcommand: edit
if ($Command -eq "edit") {
    Write-Host "Opening skills.txt in Notepad..." -ForegroundColor Cyan
    Start-Process notepad.exe -ArgumentList "`"$skillsFile`"" -Wait
    Write-Host "Syncing changes to GitHub..." -ForegroundColor Yellow
    git -C "$scriptDir" add skills.txt
    git -C "$scriptDir" commit -m "update skills list"
    git -C "$scriptDir" push origin main
    Write-Host ""
    Write-Host "[DONE] Master skills updated and pushed to GitHub!" -ForegroundColor Green
    Write-Host ""
    exit 0
}

# Subcommand: list
if ($Command -eq "list") {
    Write-Host ""
    Write-Host "========================================================" -ForegroundColor Cyan
    Write-Host "        CURRENT FAVORITE SKILLS (SKILES)                " -ForegroundColor Cyan
    Write-Host "========================================================" -ForegroundColor Cyan
    if (Test-Path $skillsFile) {
        Get-Content $skillsFile | Where-Object {
            $t = $_.Trim()
            $t -ne "" -and -not $t.StartsWith("#") -and -not $t.StartsWith(";")
        } | ForEach-Object { Write-Host "  - $_" }
    }
    Write-Host ""
    Write-Host "--------------------------------------------------------" -ForegroundColor DarkGray
    Write-Host "  BUILT-IN 1-CLICK SUITES AVAILABLE:" -ForegroundColor Yellow
    Write-Host "    - videoprompt (20 AI Video Director Skills)" -ForegroundColor Cyan
    Write-Host "      Type 'videoprompt' or 'skills videoprompt' to install" -ForegroundColor DarkGray
    Write-Host "========================================================" -ForegroundColor Cyan
    Write-Host ""
    exit 0
}

# Subcommand: add [repo] [skill]
if ($Command -eq "add") {
    $repo = $Arg1
    $skillName = $Arg2

    if ($repo -eq "videoprompt" -or $repo -eq "video") {
        $newEntry = "https://github.com/sutradhardeba710/SKILES --skill videoprompt"
        Add-Content -Path $skillsFile -Value $newEntry -Encoding utf8
        Write-Host ""
        Write-Host "[SAVED] Added videoprompt suite to master list!" -ForegroundColor Green

        Write-Host "[GIT] Syncing to GitHub..." -ForegroundColor Yellow
        git -C "$scriptDir" add skills.txt
        git -C "$scriptDir" commit -m "add skill: videoprompt suite"
        git -C "$scriptDir" push origin main

        Install-VideoSkillsSuite -TargetDir (Get-Location).Path
        exit 0
    }

    if (-not $repo) {
        Write-Host ""
        Write-Host "==========================================" -ForegroundColor Cyan
        Write-Host "             ADD NEW AI SKILL             " -ForegroundColor Cyan
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
    Write-Host ""
    Write-Host "[SAVED] Added to master list: $newEntry" -ForegroundColor Green

    Write-Host "[GIT] Syncing to GitHub..." -ForegroundColor Yellow
    git -C "$scriptDir" add skills.txt
    git -C "$scriptDir" commit -m "add skill: $newEntry"
    git -C "$scriptDir" push origin main

    Write-Host ""
    Write-Host "[INSTALLING] Installing $newEntry to current project..." -ForegroundColor Green
    $cmdParts = $newEntry -split "\s+"
    $argsList = @("--yes", "skills", "add") + $cmdParts + @("--agent", "antigravity", "--copy", "-y")
    & npx.cmd @argsList

    Write-Host ""
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "   DONE! SAVED, PUSHED & INSTALLED!       " -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host ""
    exit 0
}

# Subcommand: all
if ($Command -eq "all") {
    Install-VideoSkillsSuite -TargetDir (Get-Location).Path
}

# Normal install flow (skills without arguments)
Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "       AI SKILLS INSTALLER (SKILES)       " -ForegroundColor Cyan
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

Write-Host "Mode: Full physical copy (--copy)" -ForegroundColor Gray
Write-Host ""

if (Test-Path $skillsFile) {
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
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "      ALL FAVORITE SKILLS INSTALLED       " -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
