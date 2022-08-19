$RG = 'AZ-PS-RG'
$NSG_NAME = 'test-nsg-01'
# Region is only provided when we create the NSG (the command below), later on I just update it instead of creatning new NSG
# $NSG = New-AzNetworkSecurityGroup -Name $NSG_NAME -ResourceGroupName $RG  -Location  "francecentral"
$NSG = Get-AzNetworkSecurityGroup -Name $NSG_NAME `
                 -ResourceGroupName $RG

foreach($rule in import-csv ".\nsg-rules.csv")
{
  
    $NSG | Add-AzNetworkSecurityRuleConfig -Name $rule.name `
           -Access Allow -Protocol Tcp -Direction $rule.direction -Priority $rule.priority `
           -SourceAddressPrefix $rule.source -SourcePortRange * `
           -DestinationAddressPrefix $rule.destination -DestinationPortRange $rule.port
}

$NSG | Set-AzNetworkSecurityGroup