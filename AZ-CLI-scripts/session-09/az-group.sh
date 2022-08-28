#!/bin/bash
RG_NAME=$1
location=westeurope
az group create \
  --name $RG_NAME \
  --location $location