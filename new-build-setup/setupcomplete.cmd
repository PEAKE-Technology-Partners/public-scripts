@echo off
set SCRIPT_URL=https://raw.githubusercontent.com/PEAKE-Technology-Partners/public-scripts/main/new-build-setup/drivers.ps1
set SCRIPT_FILE=%TEMP%\drivers.ps1

REM Download the PowerShell script
powershell -Command "$webClient = New-Object Net.WebClient; $webClient.DownloadProgressChanged += { Write-Progress -Activity 'Script Download' -Status ('Downloading {0}' -f $_.FileName) -PercentComplete $_.ProgressPercentage }; $webClient.DownloadFileAsync('%SCRIPT_URL%', '%SCRIPT_FILE%')"

REM Wait for the script download to complete
powershell -Command "while (Test-Path -Path '%SCRIPT_FILE%.part') { Start-Sleep -Seconds 1 }"

REM Execute the downloaded PowerShell script
powershell -ExecutionPolicy Bypass -File "%SCRIPT_FILE%"

REM Clean up the downloaded script file
del "%SCRIPT_FILE%"

exit /b
