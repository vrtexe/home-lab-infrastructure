#!/usr/bin/env bash

directory=$(dirname "$0")

source "$directory/../config.sh"

mkdir -p $PROXMOX_TOKEN_DIRECTORY

pveum group delete $TERRAFORM_GROUP &> /dev/null
pveum group add $TERRAFORM_GROUP

pveum acl modify / --groups $TERRAFORM_GROUP --roles $TERRAFORM_ROLES

pveum user delete $TERRAFORM_USER &> /dev/null
pveum user add $TERRAFORM_USER --comment "Terraform Automation Account" --groups $TERRAFORM_GROUPS

pveum user token remove $TERRAFORM_USER $TERRAFORM_TOKEN &> /dev/null
pveum user token add $TERRAFORM_USER $TERRAFORM_TOKEN --privsep=0 --output-format json > $PROXMOX_TOKEN_DIRECTORY/$TERRAFORM_SECRET_FILE
