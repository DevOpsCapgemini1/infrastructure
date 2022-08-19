
# Parametrs to specify
$RG = 'AZ-PS-RG'
$NSG_NAME='test-nsg-01'
$SubnetName = 'mySubnet-ps'
$vnetName='myVNet'
##
$NSG = Get-AzNetworkSecurityGroup -Name $NSG_NAME -ResourceGroupName $RG
$vnet = Get-AzVirtualNetwork -Name $vnetName -ResourceGroupName $RG
$subnet = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name $SubnetName
$subnet.NetworkSecurityGroup = $NSG
Set-AzVirtualNetwork -VirtualNetwork $vnet
