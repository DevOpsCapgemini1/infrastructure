#!/bin/bash
echo "Creating NSG with  rule"
RG="IaC-tasks7"
nsgName="myNSG"
loc="uksouth"
nsgRule='myNsgRule'
priorityNum=1000
az network nsg create -g $RG -n $nsgName -l $loc
az network nsg rule create -g $RG --nsg-name $nsgName -n $nsgRule --priority $priorityNum