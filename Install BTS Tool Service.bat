@echo off
chcp 65001 >nul
:: ============================================================
::  Create Desktop Shortcut for ToolService Web App
::  URL: https://smocsthbts-ui.github.io/ToolService/
:: ============================================================

setlocal

set "APP_NAME=ToolService"
set "APP_URL=https://smocsthbts-ui.github.io/ToolService/"
set "DESKTOP=%USERPROFILE%\Desktop"
set "SHORTCUT=%DESKTOP%\%APP_NAME%.lnk"

:: Windows built-in icon (shell32.dll index 14 = Globe/Internet)
set "ICON_PATH=shell32.dll"
set "ICON_INDEX=14"

echo.
echo  ====================================================
echo   Creating Shortcut: %APP_NAME%
echo  ====================================================
echo.

echo  [1/2] Creating Desktop Shortcut...

set "VBS_TEMP=%TEMP%\make_shortcut_%APP_NAME%.vbs"

(
    echo Set oWS = WScript.CreateObject^("WScript.Shell"^)
    echo sLinkFile = "%SHORTCUT%"
    echo Set oLink = oWS.CreateShortcut^(sLinkFile^)
    echo oLink.TargetPath = "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
    echo oLink.Arguments = "--app=%APP_URL%"
    echo oLink.Description = "%APP_NAME% Web App"
    echo oLink.IconLocation = "%ICON_PATH%, %ICON_INDEX%"
    echo oLink.WorkingDirectory = "%USERPROFILE%"
    echo oLink.Save
) > "%VBS_TEMP%"

cscript //nologo "%VBS_TEMP%"
del "%VBS_TEMP%" 2>nul

echo  [2/2] Checking result...

if exist "%SHORTCUT%" (
    echo.
    echo  ====================================================
    echo   [SUCCESS] Shortcut created!
    echo   Path: %SHORTCUT%
    echo  ====================================================
    echo.
    echo   Double-click "ToolService" on Desktop
    echo   Opens in Edge App Mode ^(no Address Bar^)
) else (
    echo.
    echo   [ERROR] Could not create shortcut.
    echo   Please make sure Microsoft Edge is installed.
)

echo.
pause
endlocal
