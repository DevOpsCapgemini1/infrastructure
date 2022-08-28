#!/bin/bash
echo "Creating NSG with  rule"
RG=$1
nsgName="myNSG"
loc="uksouth"
nsgRule='myNsgRule'
priorityNum=1000
arrayRules=(Allow Inbound Tcp)
az network nsg create -g $RG -n $nsgName -l $loc
az network nsg rule create\
    --resource-group $RG\
    --nsg-name $nsgName\
    --name $nsgRule\
    --priority $priorityNum\
    --access ${arrayRules[0]}\
    --direction ${arrayRules[1]}\
    --protocol ${arrayRules[2]}\
