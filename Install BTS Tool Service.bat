@echo off
chcp 65001 >nul
title Install BTS Tool Service

echo.
echo  ====================================================
echo   BTS Tool Service - Desktop Installer
echo  ====================================================
echo.
echo   This will create a shortcut on your Desktop.
echo   URL: https://smocsthbts-ui.github.io/ToolService/
echo.
echo  Press any key to start installation...
pause >nul

:: --- Variables ---
set "APP_NAME=BTS Tool Service"
set "APP_URL=https://smocsthbts-ui.github.io/ToolService/"
set "DESKTOP=%PUBLIC%\Desktop"
set "SHORTCUT=%DESKTOP%\%APP_NAME%.lnk"
set "ICON_PATH=shell32.dll"
set "ICON_INDEX=14"

:: --- Check Edge installed ---
echo.
echo  [1/3] Checking Microsoft Edge...
if exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" (
    set "EDGE_PATH=%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
    echo        Edge found.
) else if exist "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" (
    set "EDGE_PATH=%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"
    echo        Edge found.
) else (
    echo.
    echo   [ERROR] Microsoft Edge not found.
    echo   Please install Edge from https://www.microsoft.com/edge
    echo.
    pause
    exit /b 1
)

:: --- Create Shortcut ---
echo  [2/3] Creating Desktop Shortcut...

set "VBS_TEMP=%TEMP%\install_bts_tool.vbs"

(
    echo Set oWS = WScript.CreateObject^("WScript.Shell"^)
    echo Set oLink = oWS.CreateShortcut^("%SHORTCUT%"^)
    echo oLink.TargetPath = "%EDGE_PATH%"
    echo oLink.Arguments = "--app=%APP_URL%"
    echo oLink.Description = "BTS Tool Service Web App"
    echo oLink.IconLocation = "%ICON_PATH%, %ICON_INDEX%"
    echo oLink.WorkingDirectory = "%USERPROFILE%"
    echo oLink.Save
) > "%VBS_TEMP%"

cscript //nologo "%VBS_TEMP%"
del "%VBS_TEMP%" 2>nul

:: --- Result ---
echo  [3/3] Checking result...

if exist "%SHORTCUT%" (
    echo.
    echo  ====================================================
    echo   [SUCCESS] Installation Complete!
    echo   Shortcut: %SHORTCUT%
    echo  ====================================================
    echo.
    echo   Double-click "BTS Tool Service" on Desktop to launch.
    echo.
) else (
    echo.
    echo   [ERROR] Could not create shortcut.
    echo   Try running this file as Administrator.
    echo.
)

pause
exit /b
