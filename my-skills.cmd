@echo off
setlocal enabledelayedexpansion

echo.
echo ==========================================
echo        AI SKILLS INSTALLER (SKILES)
echo ==========================================
echo Working Directory: %CD%

set "SKILLS_FILE=%~dp0skills.txt"

if not exist "%SKILLS_FILE%" (
    echo [ERROR] skills.txt not found at: "%SKILLS_FILE%"
    exit /b 1
)

:: Check if user provided a specific agent flag
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
