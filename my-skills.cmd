@echo off
setlocal enabledelayedexpansion

set "SKILES_DIR=%~dp0"
set "SKILLS_FILE=%SKILES_DIR%skills.txt"

if not exist "%SKILLS_FILE%" (
    echo [ERROR] skills.txt not found at: "%SKILLS_FILE%"
    exit /b 1
)

:: Subcommand: my-skills edit
if /i "%~1"=="edit" (
    echo Opening skills.txt in Notepad...
    notepad "%SKILLS_FILE%"
    echo Syncing changes to GitHub...
    git -C "%SKILES_DIR%." add skills.txt
    git -C "%SKILES_DIR%." commit -m "update skills list"
    git -C "%SKILES_DIR%." push origin main
    echo.
    echo [DONE] Master skills updated and pushed to GitHub!
    exit /b 0
)

:: Subcommand: my-skills list
if /i "%~1"=="list" (
    echo.
    echo ==========================================
    echo        CURRENT FAVORITE SKILLS
    echo ==========================================
    for /f "usebackq eol=# tokens=*" %%A in ("%SKILLS_FILE%") do (
        echo   - %%A
    )
    echo ==========================================
    echo.
    exit /b 0
)

:: Subcommand: my-skills add [repo] [skill]
if /i "%~1"=="add" (
    shift
    goto :DoAdd
)

goto :DoInstall

:DoAdd
set "REPO=%~1"
set "SKILL_NAME=%~2"

if "%REPO%"=="" (
    echo.
    echo ==========================================
    echo             ADD NEW AI SKILL
    echo ==========================================
    set /p "REPO=Enter GitHub repo URL (e.g. anthropics/skills): "
)

if "%REPO%"=="" (
    echo [ERROR] No repository provided.
    exit /b 1
)

if "%SKILL_NAME%"=="" (
    set /p "SKILL_NAME=Enter skill name (press Enter for all skills): "
)

if "%SKILL_NAME%"=="" (
    set "NEW_ENTRY=%REPO% --skill *"
) else (
    set "NEW_ENTRY=%REPO% --skill %SKILL_NAME%"
)

echo.
echo %NEW_ENTRY%>>"%SKILLS_FILE%"
echo [SAVED] Added to master list: %NEW_ENTRY%

echo [GIT] Syncing to GitHub...
git -C "%SKILES_DIR%." add skills.txt
git -C "%SKILES_DIR%." commit -m "add skill: %NEW_ENTRY%"
git -C "%SKILES_DIR%." push origin main

echo.
echo [INSTALLING] Installing %NEW_ENTRY% to current project...
call npx --yes skills add %NEW_ENTRY% --agent antigravity --copy -y
echo.
echo ==========================================
echo   DONE! SAVED, PUSHED & INSTALLED!
echo ==========================================
echo.
exit /b 0

:DoInstall
echo.
echo ==========================================
echo        AI SKILLS INSTALLER (SKILES)
echo ==========================================
echo Working Directory: %CD%

:: Check if user provided an agent flag
set "EXTRA_AGENT="
echo %* | findstr /i "\--agent \-a" >nul
if errorlevel 1 (
    set "EXTRA_AGENT=--agent antigravity"
    echo Target Folder: .agents\skills\ (Universal)
)

echo Mode: Full physical copy (--copy)
echo.

for /f "usebackq eol=# tokens=*" %%A in ("%SKILLS_FILE%") do (
    set "line=%%A"
    if not "!line!"=="" (
        echo.
        echo [INSTALLING] !line! !EXTRA_AGENT! %*
        call npx --yes skills add !line! !EXTRA_AGENT! --copy %* -y
    )
)

echo.
echo ==========================================
echo       ALL FAVORITE SKILLS INSTALLED
echo ==========================================
echo.
