#!/bin/bash
RG="IaC-tasks7-vm"
vmName="myVM"
image="UbuntuLTS"
price="50"
vnetName="myVNET"
subnetName="mySubnet1"
reservedIP="20.111.33.210"
dnsName="vm-create-az-cli"

if [[ "$dnsName" == "" && "$reservedIP" == "" ]] ;
then
   az vm create --name $vmName --resource-group $RG --image $image --vnet-name $vnetName --subnet $subnetName  --generate-ssh-keys
elif [[ "$dnsName" != "" && "$reservedIP" == "" ]] ;
then
    az vm create --name $vmName --resource-group $RG --image $image --vnet-name $vnetName --subnet $subnetName --generate-ssh-keys --public-ip-address-dns-name $dnsName
elif [[ "$dnsName" = "" && "$reservedIP" != "" ]] ;
then
    az vm create --name $vmName --resource-group $RG --image $image --vnet-name $vnetName --subnet $subnetName --generate-ssh-keys --public-ip-address $reservedIP --public-ip-address-allocation static 
else
    az vm create --name $vmName --resource-group $RG --image $image --vnet-name $vnetName --subnet $subnetName --public-ip-address $reservedIP --public-ip-address-dns-name $dnsName  --generate-ssh-keys --public-ip-address-allocation static
fi