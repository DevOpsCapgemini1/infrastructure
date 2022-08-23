# $rg = @{
#     Name = 'AZ-PS-RG'
#     Location = 'francecentral'
# }
# New-AzResourceGroup @rg

#create the VNET
$vnet = @{
    Name = 'myVNet'
    ResourceGroupName = 'AZ-PS-RG'
    Location = 'francecentral'
    AddressPrefix = '10.0.0.0/16'    
}
$virtualNetwork = New-AzVirtualNetwork @vnet


# Here you can add more subnets
$subnets = 
@'
SubnetName,AddressPrefix
"mySubnet-ps","10.0.0.0/24" 
"mySubnet-ps2","10.0.1.0/24"
"mySubnet-ps3","10.0.2.0/24"
'@ | 
ConvertFrom-Csv


foreach ($subnet in $subnets) {
 
    $dmz = New-AzVirtualNetworkSubnetConfig -Name $subnet.SubnetName -AddressPrefix $subnet.AddressPrefix

    $updatedvnet=Add-AzVirtualNetworkSubnetConfig -Name $dmz.Name -VirtualNetwork $virtualNetwork -AddressPrefix $dmz.AddressPrefix

    $updatedvnet | Set-AzVirtualNetwork


}