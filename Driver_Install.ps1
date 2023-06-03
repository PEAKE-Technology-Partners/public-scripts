$MODEL = Get-CimInstance -ClassName Win32_BIOS | Select-Object Manufacturer;
if($MODEL -like '*Dell*') {
#Install Dell Command Update
%programdata%\chocolatey\choco.exe install dellcommandupdate-uwp -y

$dcuCliPath = "${env:ProgramFiles}\Dell\CommandUpdate\dcu-cli.exe"
$arguments = '/configure', '-userConsent=disable', '-lockSettings=enable', '-autoSuspendBitLocker=enable', '-silent', '-scheduleWeekly=Mon,16:45', '-scheduleAction=DownloadInstallAndNotify'
Start-Process -FilePath $dcuCliPath -ArgumentList $arguments -Wait


if (Test-Path -Path "HKLM:\SOFTWARE\Dell\UpdateService\Clients\CommandUpdate\Preferences\CFG") {[void](New-ItemProperty -Path "HKLM:\SOFTWARE\Dell\UpdateService\Clients\CommandUpdate\Preferences\CFG" -Name "ShowSetupPopup" -Value 0 -PropertyType DWord -Force)}

} elseif ($MODEL -like '*Lenovo*') {
#Install Lenovo System Update
%programdata%\chocolatey\choco.exe install lenovo-thinkvantage-system-update -y

# Write to HKLM\SOFTWARE\WOW6432Node\Lenovo\System Update\Preferences\UserSettings\General\MetricsEnabled value NO, to disable metrics
if (Test-Path -Path "HKLM:\SOFTWARE\WOW6432Node\Lenovo\System Update\Preferences\UserSettings\General") {[void](New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Lenovo\System Update\Preferences\UserSettings\General" -Name "MetricsEnabled" -Value "NO" -PropertyType String -Force)}

# Write to HKLM\SOFTWARE\WOW6432Node\Lenovo\System Update\Preferences\UserSettings\General\DisplayLicenseNotice value NO, to disable License
if (Test-Path -Path "HKLM:\SOFTWARE\WOW6432Node\Lenovo\System Update\Preferences\UserSettings\General") {[void](New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Lenovo\System Update\Preferences\UserSettings\General" -Name "DisplayLicenseNotice" -Value "NO" -PropertyType String -Force)}

# Write to HKLM\SOFTWARE\WOW6432Node\Lenovo\System Update\Preferences\UserSettings\General\AskBeforeClosing value NO, to disable prompt on closing
if (Test-Path -Path "HKLM:\SOFTWARE\WOW6432Node\Lenovo\System Update\Preferences\UserSettings\General") {[void](New-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Lenovo\System Update\Preferences\UserSettings\General" -Name "AskBeforeClosing" -Value "NO" -PropertyType String -Force)}

} else {
    #This isn't an HP, Dell, or Lenovo
    Write-Host "This isn't an Dell, or Lenovo Device"

}
