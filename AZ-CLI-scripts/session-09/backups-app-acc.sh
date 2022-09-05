#!/bin/bash

let "randomIdentifier=$RANDOM*$RANDOM"
location="westeurope"
resourceGroup=$1
tag="backups-app-acc.sh"
appServicePlan="xyf-app-service-plan-$randomIdentifier"
webapp="xyf-web-app-$randomIdentifier"
storage="xyf-webappstorage$randomIdentifier"
container="xyf-appbackup$randomIdentifier"
backup="backup$randomIdentifier"
expirydate=$(date -I -d "$(date) + 1 month")


# echo "Creating $resourceGroup in "$location"..."
# az group create --name $resourceGroup --location "$location" --tag $tag


echo "Creating $storage"
az storage account create --name $storage --resource-group $resourceGroup --location "$location" \
--sku Standard_LRS


echo "Creating $container on $storage..."
key=$(az storage account keys list --account-name $storage --resource-group $resourceGroup -o json --query [0].value | tr -d '"')

az storage container create --name $container --account-key $key --account-name $storage


sastoken=$(az storage container generate-sas --account-name $storage --name $container --account-key $key \
--expiry $expirydate --permissions rwdl --output tsv)


sasurl=https://$storage.blob.core.windows.net/$container?$sastoken


echo "Creating $appServicePlan"
az appservice plan create --name $appServicePlan --resource-group $resourceGroup --location "$location" \
--sku S1


echo "Creating $webapp"
az webapp create --name $webapp --plan $appServicePlan --resource-group $resourceGroup


echo "Creating $backup"
az webapp config backup create --resource-group $resourceGroup --webapp-name $webapp \
--backup-name $backup --container-url $sasurl




az webapp config backup update --resource-group $resourceGroup --webapp-name $webapp \
--container-url $sasurl --frequency 1d --retain-one true --retention 10




