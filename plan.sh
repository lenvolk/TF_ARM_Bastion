#!/bin/bash
set -e
###############################################################
# Script Parameters                                           #
###############################################################

while getopts c:e:r:p: option
do
    case "${option}"
    in
    c) APP_NAME=${OPTARG};;
    e) ENVIRONMENT=${OPTARG};;
    r) REGION=${OPTARG};;
    p) PASSWORD=${OPTARG};;
    esac
done

if [ -z "$APP_NAME" ]; then
    echo "-c is a required argument - Resource Group Name for storage account"
    exit 1
fi
if [ -z "$ENVIRONMENT" ]; then
    echo "-e is a required argument - Environment (dev, prod)"
    exit 1
fi
if [ -z "$REGION" ]; then
    echo "-r is a required argument - Region (eastus, eastus2)"
    exit 1
fi
if [ -z "$PASSWORD" ]; then
    echo "-p is a required argument - PASSWORD (xxxx@1111)"
    exit 1
fi

###############################################################
# Script Begins                                               #
###############################################################
RESOURCE_GROUP_NAME=${APP_NAME}${ENVIRONMENT}
STORAGE_ACCOUNT_NAME=${APP_NAME}${ENVIRONMENT}

ARM_SUBSCRIPTION_ID=$(az account show --query id --out tsv)
ARM_TENANT_ID=$(az account show --query tenantId --out tsv)
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query [0].value -o tsv)

terraform plan -input=false \
 --var tenant=$ARM_TENANT_ID \
 --var subscription=$ARM_SUBSCRIPTION_ID \
 --var prefix=${RESOURCE_GROUP_NAME} \
 --var location=${REGION} \
 --var env=${ENVIRONMENT} \
 --var password=${PASSWORD} \
 -out=$ENVIRONMENT.plan

