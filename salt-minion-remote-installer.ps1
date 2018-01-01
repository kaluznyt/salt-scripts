# https://docs.saltstack.com/en/latest/topics/installation/windows.html

$remoteMachines = @(
	"192.168.159.3"
)

$saltMinionInstallerExe = "Salt-Minion-2017.7.2-Py3-AMD64-Setup.exe"

$saltMinionInstallerLocalPath = "D:\vms\vagrant\salt\$saltMinionInstallerExe"
$saltMinionInstallerUrl = "https://repo.saltstack.com/windows/$saltMinionInstallerExe"

if(!(Test-Path $saltMinionInstallerLocalPath))
{
	Start-BitsTransfer -Source $saltMinionInstallerUrl -Destination $saltMinionInstallerLocalPath
}

$remoteTempFolder = "c:\windows\temp\"
$remoteTempFile = $remoteTempFolder + $saltMinionInstallerExe

$saltMasterName = "salt"
$saltMinionName = "minion-1"

	#md -Force $tempPath
	#Start-BitsTransfer -Source $saltMinionInstallerUrl -Destination $tempPath
	#Invoke-WebRequest $saltMinionInstallerUrl -OutFile $tempPath -UseBasicParsing

$cred = Get-Credential

if($cred)
{
$remoteMachines |% {
	$hostName = $_
	
	$session = New-PSSession -ComputerName $hostName -Credential $cred
	
	copy-item $saltMinionInstallerLocalPath $remoteTempFile -ToSession $session
	
	Invoke-Command -Session $session -ArgumentList $remoteTempFile -ScriptBlock  { param($p1)
		#Start-Process c:\windows\temp\installer.exe -ArgumentList '/silent' -Wait
		Start-Process $p1 -ArgumentList '/S /master=$saltMasterName /minion-name=$saltMinionName /start-minion=1' -Wait
		
	}	
}
}