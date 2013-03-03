##  set user and password
$USER=
$PASSWORD=

##  array of esx hosts... this could be read in from a file easily
$all= @("esx01","esx02","esx03")

Disconnect-VIServer * -Confirm:$false
foreach ($vm in $all) {
  Connect-VIServer $vm -User $USER -password $PASSWORD
  $version = Get-View -Server $vm -ViewType hostsystem -Property Name, Config.product | select Name, {$_.Config.product.fullname}
  echo $version
  Disconnect-VIServer -Confirm:$false
}
