

# $RGname="AZ-PS-RG"
# $port=8081
# $rulename="allowAppPort$port"
# $nsgname="test-nsg-01"

# # Get the NSG resource
# $nsg = Get-AzNetworkSecurityGroup -Name $nsgname -ResourceGroupName $RGname

# # Add the inbound security rule.
# $nsg | Add-AzNetworkSecurityRuleConfig -Name $rulename -Description "Allow app port" -Access Allow `
#     -Protocol * -Direction Inbound -Priority 3891 -SourceAddressPrefix "*" -SourcePortRange * `
#     -DestinationAddressPrefix * -DestinationPortRange $port

# # Update the NSG.
# $nsg | Set-AzNetworkSecurityGroup