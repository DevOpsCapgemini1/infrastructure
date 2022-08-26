Connect-AzAccount
$cred = Get-Credential -Message "Enter a username and password for the virtual machine."
$RG = 'New-AZ-PG-SR'
$VM_NAME = 'AZ-PS-VM'
$location = 'francecentral'
$image = 'UbuntuLTS'
$size = 'Standard_D2s_v3'
$vnetName='myVVNET'
$SubnetName = 'mySubnet-ps'
$dnsName='azure-dns-vm-f3z'
$reservedIP= '20.117.159.105'


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



