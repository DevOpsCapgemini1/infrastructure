$nsgConf = import-csv ".\nsg-conf.csv"
$assignConf = import-csv ".\subnets-to-assign.csv"

$RG = $nsgConf.ResourceGroupName
$NSG_NAME = $nsgConf.NsgName

foreach ($assign in  $assignConf) {
    echo $assign.VnetName $assign.SubnetName
    $NSG = Get-AzNetworkSecurityGroup -Name $NSG_NAME -ResourceGroupName $RG
    $vnet = Get-AzVirtualNetwork -Name $assign.VnetName -ResourceGroupName $RG
    $subnet = Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name $assign.SubnetName
    $subnet.NetworkSecurityGroup = $NSG
    Set-AzVirtualNetwork -VirtualNetwork $vnet
}

