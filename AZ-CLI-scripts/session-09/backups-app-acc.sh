#!/bin/bash
# Backup and restore a web app from a backup
# set -e # exit if error
# Variable block
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

# Create a resource group.
# echo "Creating $resourceGroup in "$location"..."
# az group create --name $resourceGroup --location "$location" --tag $tag

# Create a Storage Account
echo "Creating $storage"
az storage account create --name $storage --resource-group $resourceGroup --location "$location" \
--sku Standard_LRS

# Create a storage container
echo "Creating $container on $storage..."
key=$(az storage account keys list --account-name $storage --resource-group $resourceGroup -o json --query [0].value | tr -d '"')

az storage container create --name $container --account-key $key --account-name $storage

# Generate a SAS token for the storage container, valid for one month.
# NOTE: You can use the same SAS token to make backups in App Service until --expiry
sastoken=$(az storage container generate-sas --account-name $storage --name $container --account-key $key \
--expiry $expirydate --permissions rwdl --output tsv)

# Construct the SAS URL for the container
sasurl=https://$storage.blob.core.windows.net/$container?$sastoken

# Create an App Service plan in Standard tier. Standard tier allows one backup per day.
echo "Creating $appServicePlan"
az appservice plan create --name $appServicePlan --resource-group $resourceGroup --location "$location" \
--sku S1

# Create a web app
echo "Creating $webapp"
az webapp create --name $webapp --plan $appServicePlan --resource-group $resourceGroup

# Create a one-time backup
echo "Creating $backup"
az webapp config backup create --resource-group $resourceGroup --webapp-name $webapp \
--backup-name $backup --container-url $sasurl



# Schedule a backup every day and retain for 10 days
az webapp config backup update --resource-group $resourceGroup --webapp-name $webapp \
--container-url $sasurl --frequency 1d --retain-one true --retention 10




