#!/bin/bash
set -xe

terraform fmt -check -recursive
terraform validate

terraform plan -var-file=./config/dev.tfvars -out tfplan.tmp
