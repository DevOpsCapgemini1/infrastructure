$vmConf = import-csv ".\vmConf.csv"
Connect-AzAccount
$cred = Get-Credential -Message "Enter a username and password for the virtual machine."
$RG = $vmConf.RG
$VM_NAME = $vmConf.vmName
$location = $vmConf.location
$image = $vmConf.image
$size = $vmConf.size
$vnetName= $vmConf.vnetName
$SubnetName = $vmConf.subnetName
$dnsName=$vmConf.dnsName
$reservedIP= $vmConf.reservedIP


$vmParams = @{
  ResourceGroupName = $RG
  Name = $VM_NAME
  Location = $location
  ImageName = $image
  Credential = $cred
  VirtualNetworkName = $vnetName
  SubnetName = $SubnetName
  Size = $size
}

if(-not [string]::IsNullOrWhiteSpace($dnsName)){
    $vmParams['DomainNameLabel'] = $dnsName
 
}

if(-not [string]::IsNullOrWhiteSpace($reservedIP)){
    $vmParams['PublicIpAddressName'] = $reservedIP

}

$newVM1 = New-AzVM @vmParams



