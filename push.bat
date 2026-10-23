@echo off
REM Commit every change in this repo and push it to GitHub.
REM Place this file in the repo's top folder and double-click it.
cd /d "%~dp0"

git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
    echo This folder is not a Git repository.
    pause
    exit /b 1
)

echo Changes in this repo:
git status --short
echo.

set "CHANGES="
for /f "delims=" %%i in ('git status --porcelain') do set "CHANGES=1"

if not defined CHANGES goto push

set "MSG="
set /p "MSG=Commit message (leave blank for a timestamp): "
if not defined MSG set "MSG=Update %date% %time%"

git add -A
git commit -m "%MSG%"
if errorlevel 1 (
    echo Commit failed. Read the message above.
    pause
    exit /b 1
)

:push
echo.
echo Pushing to GitHub...
git push
if errorlevel 1 (
    echo.
    echo Push failed. If GitHub has changes you don't have yet, run pull.bat first, then push.bat again.
    pause
    exit /b 1
)

echo.
echo Done. Everything is on GitHub.
pause
