# https://docs.saltstack.com/en/latest/topics/installation/windows.html
https://www.vagrantup.com/docs/provisioning/shell.html

$saltMasterName = "salt"
$saltMinionName = "minion-1"

$saltMinionInstallerExe = "Salt-Minion-2017.7.2-Py2-AMD64-Setup.exe"

$saltMinionInstallerLocalPath = "D:\vms\vagrant\salt\$saltMinionInstallerExe"
$saltMinionInstallerUrl = "https://repo.saltstack.com/windows/$saltMinionInstallerExe"

if(!(Test-Path $saltMinionInstallerLocalPath))
{
	Start-BitsTransfer -Source $saltMinionInstallerUrl -Destination $saltMinionInstallerLocalPath
}

$remoteTempFolder = "c:\windows\temp\"
$remoteTempFile = $remoteTempFolder + $saltMinionInstallerExe
	
copy-item $saltMinionInstallerLocalPath $remoteTempFile -ToSession $session
	
Start-Process $remoteTempFile -ArgumentList '/S /master=$saltMasterName /minion-name=$saltMinionName /start-minion=1' -Wait
		


