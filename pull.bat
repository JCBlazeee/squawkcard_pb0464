@echo off
REM Bring down the latest changes from GitHub into this repo.
REM Place this file in the repo's top folder and double-click it.
cd /d "%~dp0"

git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
    echo This folder is not a Git repository.
    pause
    exit /b 1
)

set "CHANGES="
for /f "delims=" %%i in ('git status --porcelain') do set "CHANGES=1"
if defined CHANGES (
    echo Note: you have changes that aren't committed yet.
    echo If the pull fails, run push.bat first, then pull.bat again.
    echo.
)

echo Pulling from GitHub...
git pull --no-edit
if errorlevel 1 (
    echo.
    echo Pull failed. Read the message above. If it mentions a conflict, ask Claude Code to help resolve it.
    pause
    exit /b 1
)

echo.
echo Done. You have the latest version.
pause
