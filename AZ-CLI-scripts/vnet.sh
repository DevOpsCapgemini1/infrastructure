#!/bin/bash
echo "Creating VNET with x subnets"
ResourceGroup="IaC-tasks7"
vnetName="myVNET"
location="uksouth"
vnetAdress="10.1.0.0/16"
subnetArray=(mySubnet1 10.1.0.0/24 mySubnet2 10.1.2.0/24 mySubnet3 10.1.3.0/24 mySubnet4 10.1.4.0/24)
len=${#subnetArray[@]}

az network vnet create -g $ResourceGroup -l $location -n $vnetName --address-prefix $vnetAdress --subnet-name ${subnetArray[0]} --subnet-prefix ${subnetArray[1]}
for ((i = 2; i < $((len - 1)); i += 2)); do az network vnet subnet create -g $ResourceGroup --vnet-name $vnetName -n ${subnetArray[$i]} --address-prefixes ${subnetArray[$((i + 1))]}; done
