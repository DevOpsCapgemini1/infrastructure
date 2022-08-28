#!/bin/bash
accName=mbidzinskiacc
RG_NAME=$1
location=westeurope
pricing_tier=Hot
az storage account create \
  --name $accName \
  --resource-group $RG_NAME \
  --location $location \
  --access-tier $pricing_tier