#!/bin/bash
RG=$1
vmName="myVM"
image="UbuntuLTS"
size="Standard_D2s_v3"
vnetName="myVNET"
subnetName="mySubnet1"
reservedIP="20.111.33.210"
dnsName="vmcreateazcli"
#diskName = 'myDISK'
#az disk create --$diskName --$RG --tier

if [[ "$dnsName" == "" && "$reservedIP" == "" ]]; then
    az vm create\
        --name $vmName\
        --resource-group $RG\
        --image $image\
        --vnet-name $vnetName\
        --subnet $subnetName\
        --generate-ssh-keys\
        --size $size
elif [[ "$dnsName" != "" && "$reservedIP" == "" ]]; then
    az vm create\
        --name $vmName\
        --resource-group $RG\
        --image $image\
        --vnet-name $vnetName\
        --subnet $subnetName\
        --generate-ssh-keys\
        --public-ip-address-dns-name $dnsName\
        --size $size
elif [[ "$dnsName" = "" && "$reservedIP" != "" ]]; then
    az vm create\
        --name $vmName\
        --resource-group $RG\
        --image $image\
        --vnet-name $vnetName\
        --subnet $subnetName\
        --generate-ssh-keys\
        --public-ip-address $reservedIP\
        --public-ip-address-allocation static\
        --size $size
else
    az vm create\
        --name $vmName\
        --resource-group $RG\
        --image $image\
        --vnet-name $vnetName\
        --subnet $subnetName\
        --public-ip-address $reservedIP\
        --public-ip-address-dns-name $dnsName\
        --generate-ssh-keys\
        --public-ip-address-allocation static\
        --size $size

fi
