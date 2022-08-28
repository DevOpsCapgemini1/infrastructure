#!/bin/bash
resourceGroup=$1
appServicePlan='linux-app-service-plan'
loc='westeurope'
now=1
pricing_tier=B1
az appservice plan create\
    -g $resourceGroup\
    -n $appServicePlan\
    --location $loc\
    --is-linux\
    --number-of-workers $now\
    --sku $pricing_tier\

appName='LinuxDockerApp'

az webapp create\
    --resource-group $resourceGroup\
    --plan $appServicePlan\
    --name $appName\
    --deployment-container-image-name mcr.microsoft.com/dotnet/samples:aspnetapp


