$nsgConf = import-csv ".\nsg-conf.csv"
$RG = $nsgConf.ResourceGroupName
$NSG_NAME = $nsgConf.NsgName
$location = $nsgConf.Location
# Region is only provided when we create the NSG (the command below), later on I just update it instead of creatning new NSG
$NSG = New-AzNetworkSecurityGroup -Name $NSG_NAME -ResourceGroupName $RG  -Location $location
$NSG = Get-AzNetworkSecurityGroup -Name $NSG_NAME `
                 -ResourceGroupName $RG

foreach($rule in import-csv ".\nsg-rules.csv")
{
  
    $NSG | Add-AzNetworkSecurityRuleConfig -Name $rule.name `
           -Access $rule.Access -Protocol $rule.Protocol -Direction $rule.direction -Priority $rule.priority `
           -SourceAddressPrefix $rule.source -SourcePortRange $rule.SourcePortRange `
           -DestinationAddressPrefix $rule.destination -DestinationPortRange $rule.port
}

$NSG | Set-AzNetworkSecurityGroup