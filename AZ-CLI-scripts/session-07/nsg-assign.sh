#!/bin/bash
echo "Assigning NSG to VNet subnet"
RG=$1
nsgName="myNSG"
vnetName="myVNET"
subnetName=(mySubnet1 mySubnet2 mySubnet3)

for ((i=0; i<3; i++))
do
    az network vnet subnet update -g $RG -n ${subnetName[$i]} --vnet-name $vnetName --network-security-group $nsgName
done    
