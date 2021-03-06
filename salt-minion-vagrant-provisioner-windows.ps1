# https://docs.saltstack.com/en/latest/topics/installation/windows.html
# https://www.vagrantup.com/docs/provisioning/shell.html
PARAM($masterName, $minionName, $minionInstallerUrl)

$saltMinionInstallerExe = "Salt-Minion-2017.7.2-Py2-AMD64-Setup.exe"
$saltMinionInstallerLocalPath = "C:\tmp\$saltMinionInstallerExe"
#$saltMinionInstallerUrl = "https://repo.saltstack.com/windows/$saltMinionInstallerExe"

Write-Host "Downloading Minion setup from $minionInstallerUrl"	

if(!(Test-Path $saltMinionInstallerLocalPath))
{
	if($minionInstallerUrl.Contains("http")){
		#Start-BitsTransfer -Source $minionInstallerUrl -Destination $saltMinionInstallerLocalPath
		Invoke-WebRequest -Uri $minionInstallerUrl  -OutFile $saltMinionInstallerLocalPath
	}
	else
	{
		Copy-Item -Path $minionInstallerUrl -Destination $saltMinionInstallerLocalPath -Force
		Unblock-File $saltMinionInstallerLocalPath
	}
}

Write-Host "Installing Minion..."	

Start-Process $saltMinionInstallerLocalPath -ArgumentList "/S /master=$masterName /minion-name=$minionName /start-minion=1" -Wait

Write-Host "Installation successful !"
	


