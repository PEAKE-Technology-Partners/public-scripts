@echo off
set SCRIPT_URL=https://raw.githubusercontent.com/PEAKE-Technology-Partners/public-scripts/main/new-build-setup/drivers.ps1
set SCRIPT_FILE=%TEMP%\drivers.ps1

REM Download the PowerShell script
powershell -Command "(New-Object Net.WebClient).DownloadFile('%SCRIPT_URL%', '%SCRIPT_FILE%')"

REM Execute the downloaded PowerShell script
powershell -ExecutionPolicy Bypass -File "%SCRIPT_FILE%"

REM Clean up the downloaded script file
del "%SCRIPT_FILE%"

exit /b
