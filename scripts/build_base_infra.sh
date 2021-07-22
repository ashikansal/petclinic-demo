#!/bin/bash

resource_group="ash-master-rg"
location="eastus"
image_name="petclinic-restus"
storage_account="tf0state0sa"
storage_container="tfstate"

az login --service-principal -u $ARM_CLIENT_ID -p "$ARM_CLIENT_SECRET" --tenant $ARM_TENANT_ID
az group create -n $resource_group -l $location

az storage account create --name $storage_account --resource-group $resource_group
az storage container create --account-name $storage_account --name $storage_container