#!/usr/bin/env bash

__cfg_dir=${1:-.}

CONFIG_FILE="config.sh"

TERRAFORM_USER="terraform@pve"
TERRAFORM_TOKEN="terraform-token"
TERRAFORM_GROUP="TerraformGroup"
TERRAFORM_ROLES="Administrator"
TERRAFORM_GROUPS="$TERRAFORM_GROUP"
TERRAFORM_SECRET_FILE="terraform.json"

PROXMOX_HOST="192.168.100.2"
PROXMOX_USER="root"

PROXMOX_TOKEN_DIRECTORY="/root/tokens"
PROXMOX_SCRIPTS_DIR="scripts"
PROXMOX_BOOTSTRAP_SCRIPT="bootstrap.sh"
PROXMOX_DEST_DIR="/root"
PROXMOX_SECRET_DEST="terraform/proxmox_secret.tfvars"

LOCAL_CONFIG_DIRECTORY="$(realpath "$__cfg_dir")"
LOCAL_ROOT="$LOCAL_CONFIG_DIRECTORY/.."
LOCAL_TOKEN_DIRECTORY="$LOCAL_ROOT/data/tokens"
