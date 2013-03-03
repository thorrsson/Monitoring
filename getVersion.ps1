#	= Script to pull the version out of each ESX host you ahve
#	to be run in a powerCLI session or you need to import the VMware bits manually
# 	@author Tim Hunter
#
##  set user and password
$USER=
$PASSWORD=

##  array of esx hosts... this could be read in from a file easily
$all= @("esx01","esx02","esx03")

##	make sure we are not connected
Disconnect-VIServer * -Confirm:$false
foreach ($vm in $all) {
	##	connect to the server
	Connect-VIServer $vm -User $USER -password $PASSWORD
	##	pull the version out 
	$version = Get-View -Server $vm -ViewType hostsystem -Property Name, Config.product | select Name, {$_.Config.product.fullname}
	##	echo the version to the console
	echo $version
	##	disconnect
	Disconnect-VIServer -Confirm:$false
}
