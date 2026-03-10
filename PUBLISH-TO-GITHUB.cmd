@echo off
setlocal
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0PUSH-TO-GITHUB.ps1"
endlocal
