#!/bin/bash
set -xe

TENANT_ID=$(az account show --query tenantId -o tsv)
SUBSCRIPTION_ID=$(az account show --query id -o tsv)
storage_account_name=stestfdemoterradev
STATE_RESOURCEGROUP_NAME=rg-estfdemo-terra-dev

terraform init -upgrade \
  -backend-config=storage_account_name=$storage_account_name \
  -backend-config=container_name=terraformstate \
  -backend-config=key=terraform.tfstate \
  -backend-config=resource_group_name=$STATE_RESOURCEGROUP_NAME \
  -backend-config=tenant_id=$TENANT_ID \
  -backend-config=subscription_id=$SUBSCRIPTION_ID \

echo $ENVIRONMENT > .last-env
wait
