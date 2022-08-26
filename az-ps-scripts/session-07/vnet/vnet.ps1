$vnetConf = import-csv ".\vnet-config.csv"
$rg = @{
    Name = $vnetConf.ResourceGroupName
    Location = $vnetConf.Location
}
New-AzResourceGroup @rg


$vnet = @{
    Name = $vnetConf.VnetName
    ResourceGroupName = $vnetConf.ResourceGroupName
    Location = $vnetConf.Location
    AddressPrefix = $vnetConf.AddressPrefix  
}
$virtualNetwork = New-AzVirtualNetwork @vnet



foreach ($subnet in  import-csv ".\subnets.csv") {


    $dmz = New-AzVirtualNetworkSubnetConfig -Name $subnet.SubnetName -AddressPrefix $subnet.AddressPrefix

    $updatedvnet=Add-AzVirtualNetworkSubnetConfig -Name $dmz.Name -VirtualNetwork $virtualNetwork -AddressPrefix $dmz.AddressPrefix

    $updatedvnet | Set-AzVirtualNetwork


}