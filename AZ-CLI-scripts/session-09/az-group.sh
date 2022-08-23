#!/bin/bash
RG_NAME=storage-resource-group
location=westeurope
az group create \
  --name $RG_NAME \
  --location $location