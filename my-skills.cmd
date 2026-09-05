@echo off
setlocal enabledelayedexpansion

echo.
echo ==========================================
echo        AI SKILLS INSTALLER (SKILES)
echo ==========================================
echo Working Directory: %CD%
echo.

set "SKILLS_FILE=%~dp0skills.txt"

if not exist "%SKILLS_FILE%" (
    echo [ERROR] skills.txt not found at: "%SKILLS_FILE%"
    exit /b 1
)

for /f "usebackq tokens=*" %%A in ("%SKILLS_FILE%") do (
    set "line=%%A"
    set "first_char=!line:~0,1!"
    if not "!line!"=="" (
        if not "!first_char!"=="#" (
            if not "!first_char!"==";" (
                echo.
                echo [INSTALLING] !line! %*
                call npx --yes skills add !line! %* -y
            )
        )
    )
)

echo.
echo ==========================================
echo       ALL FAVORITE SKILLS INSTALLED
echo ==========================================
echo.
