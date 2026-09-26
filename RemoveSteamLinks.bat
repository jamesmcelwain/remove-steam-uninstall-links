@echo off
setlocal
title Remove Steam Uninstall Links From Windows

fltmc >nul 2>&1
if not %errorlevel% == 0 (
    echo You do not have Administrator Privileges. Right-click and choose "Run as administrator".
    pause
    exit /b 1
)

echo This will remove Steam game entries from the Windows uninstall list.
echo Games remain installed - this only affects Settings/Control Panel visibility.
echo Each entry is backed up to "%~dp0SteamUninstallBackup" before removal.
set "confirm="
set /p confirm="Continue? (Y/N): "
if /i not "%confirm%"=="Y" exit /b 0

set "backup=%~dp0SteamUninstallBackup"
if not exist "%backup%" mkdir "%backup%"
if not exist "%backup%" (
    echo Could not create backup folder "%backup%". Nothing was removed.
    pause
    exit /b 1
)

set count=0
set failed=0
for /F "delims=" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" 2^>nul ^| findstr /R /C:"\\Steam App [0-9][0-9]*$"') do call :remove "%%a" 64
for /F "delims=" %%a in ('reg query "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" 2^>nul ^| findstr /R /C:"\\Steam App [0-9][0-9]*$"') do call :remove "%%a" 32

echo Done. Removed %count% entries.
if not %failed% == 0 echo Failed to back up or remove %failed% entries; those were left in place.
echo Backups: "%backup%" (double-click a .reg file to restore it)
pause
exit /b 0

:remove
reg export "%~1" "%backup%\%~nx1 (%~2-bit).reg" /y >nul 2>&1
if errorlevel 1 (
    set /a failed+=1
    exit /b
)
reg delete "%~1" /f >nul 2>&1
if errorlevel 1 (
    set /a failed+=1
) else (
    set /a count+=1
)
exit /b
