@echo off
setlocal enabledelayedexpansion

echo.
echo ==========================================
echo        AI SKILLS INSTALLER (SKILES)
echo ==========================================
echo Working Directory: %CD%
echo Mode: Full physical copy (--copy enabled)
echo.

set "SKILLS_FILE=%~dp0skills.txt"

if not exist "%SKILLS_FILE%" (
    echo [ERROR] skills.txt not found at: "%SKILLS_FILE%"
    exit /b 1
)

for /f "usebackq eol=# tokens=*" %%A in ("%SKILLS_FILE%") do (
    set "line=%%A"
    if not "!line!"=="" (
        echo.
        echo [INSTALLING] !line! %*
        call npx --yes skills add !line! --copy %* -y
    )
)

echo.
echo ==========================================
echo       ALL FAVORITE SKILLS INSTALLED
echo ==========================================
echo.
