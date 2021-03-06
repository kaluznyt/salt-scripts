# https://docs.saltstack.com/en/latest/topics/installation/windows.html
# https://www.vagrantup.com/docs/provisioning/shell.html
PARAM($hostName, $ip)

Write-Host "Adding entry to hosts file"	

$hostsFile = "$env:windir\system32\drivers\etc\hosts"
$hostsFileContent = Get-Content $hostsFile
$lineToAdd = "$ip $hostName"

if(!$hostsFileContent.Contains($lineToAdd))
{
	cp $hostsFile "$hostsFile.BAK"
	
	Write-Host "Backed up hosts current hosts file"	

	Add-Content $hostsFile "`n$lineToAdd"
	
	Write-Host "Entry $lineToAdd was added to the hosts file"	
}
else
{
	Write-Host "Entry was already there"
}