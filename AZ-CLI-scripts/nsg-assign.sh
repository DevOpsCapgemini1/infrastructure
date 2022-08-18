#!/bin/bash
echo "Assigning NSG to VNet subnet"
RG="IaC-tasks7"
nsgName="myNSG"
vnetName="myVNET"
subnetName="mySubnet1"

az network vnet subnet update -g $RG -n $subnetName --vnet-name $vnetName --network-security-group $nsgName