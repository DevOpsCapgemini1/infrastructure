Connect-AzAccount
$cred = Get-Credential -Message "Enter a username and password for the virtual machine."
$RG = 'AZ-PS-RG'
$VM_NAME = 'AZ-PS-VM'
$location = 'francecentral'
$image = 'UbuntuLTS'
$publicIp = 'tutorialPublicIp'
$ports = 3389
$size = 'Standard_D2s_v3'
$vnetName='myVNet'
$SubnetName = 'mySubnet-ps'

# • VNet and subnet name
# • Custom public domain name (optional)
# • Reserved IP (optional)
$vmParams = @{
  ResourceGroupName = $RG
  Name = $VM_NAME
  Location = $location
  ImageName = $image
  PublicIpAddressName = $publicIp
  Credential = $cred
  OpenPorts = $ports
  VirtualNetworkName = $vnetName
  SubnetName = $SubnetName
  Size = $size
}
$newVM1 = New-AzVM @vmParams