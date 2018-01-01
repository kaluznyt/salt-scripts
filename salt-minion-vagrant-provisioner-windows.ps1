# https://docs.saltstack.com/en/latest/topics/installation/windows.html
# https://www.vagrantup.com/docs/provisioning/shell.html
PARAM($masterName, $minionName, $minionInstallerUrl)
{
	$saltMinionInstallerExe = "Salt-Minion-2017.7.2-Py2-AMD64-Setup.exe"
	$saltMinionInstallerLocalPath = "C:\tmp\$saltMinionInstallerExe"
	#$saltMinionInstallerUrl = "https://repo.saltstack.com/windows/$saltMinionInstallerExe"

	if(!(Test-Path $saltMinionInstallerLocalPath))
	{
		Start-BitsTransfer -Source $minionInstallerUrl -Destination $saltMinionInstallerLocalPath
	}
		
	Start-Process $saltMinionInstallerLocalPath -ArgumentList "/S /master=$masterName /minion-name=$minionName /start-minion=1" -Wait
}		


