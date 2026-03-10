@echo off
setlocal
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0STARTER-PACK-LAUNCHER.ps1" -Action Install -AutoRun
endlocal
