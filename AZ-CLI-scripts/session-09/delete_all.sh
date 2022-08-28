#!/bin/bash
rg=$1
resources="$(az resource list --resource-group $rg | grep id | awk -F \" '{print $4}')"

for id in $resources; do
    echo $id
    az resource delete --resource-group $rg --ids "$id" --verbose 
done
