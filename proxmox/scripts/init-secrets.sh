#!/usr/bin/env bash

directory=$(dirname "$0")
CONFIG_DIR="$directory/../vm"

source $CONFIG_DIR/config.sh $CONFIG_DIR

terraform_secret=$(cat $LOCAL_TOKEN_DIRECTORY/$TERRAFORM_SECRET_FILE)

token_id=$(echo $terraform_secret | jq -r '."full-tokenid"')
token_secret=$(echo $terraform_secret | jq -r '."value"')

echo "Initializing Terraform secrets at $LOCAL_ROOT/$PROXMOX_TERRAFORM_SECRET_DEST"

echo "proxmox_token_id = \"$token_id\"
proxmox_token_secret = \"$token_secret\"
" > $LOCAL_ROOT/$PROXMOX_TERRAFORM_SECRET_DEST