@echo off
title Remove Steam Uninstall Links From Windows

net session >nul 2>&1
if not %errorlevel% == 0 (
    echo You do not have Administrator Privileges. Right-click and choose "Run as administrator".
    pause
    exit /b 1
)

echo This will remove Steam game entries from the Windows uninstall list.
echo Games remain installed - this only affects Settings/Control Panel visibility.
set /p confirm="Continue? (Y/N): "
if /i not "%confirm%"=="Y" exit /b 0

set count=0
for /F "delims=" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" 2^>nul ^| findstr /C:"Steam App"') do (
    reg delete "%%a" /f >nul 2>&1
    if not errorlevel 1 set /a count+=1
)
for /F "delims=" %%a in ('reg query "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" 2^>nul ^| findstr /C:"Steam App"') do (
    reg delete "%%a" /f >nul 2>&1
    if not errorlevel 1 set /a count+=1
)

echo Done. Removed %count% entries.
pause
