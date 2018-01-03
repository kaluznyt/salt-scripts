# https://docs.saltstack.com/en/latest/topics/installation/windows.html
# https://www.vagrantup.com/docs/provisioning/shell.html
PARAM($hostName, $ip)

Write-Host "Adding entry to hosts file"	

$hostsFile = "$env:windir\system32\drivers\etc\hosts"
$hostsFileContent = Get-Content $hostsFile
$lineToAdd = "$ip $hostName"

if($hostsFileContent.Contains($lineToAdd))
{
	Write-Host "Backed up hosts current hosts file"	

	cp "$env:windir\system32\drivers\etc\hosts" "$env:windir\system32\drivers\etc\hosts.bak"

	Add-Content $hostsFile "`n$lineToAdd"
}else
{
	Write-Host "Entry was already there"
}