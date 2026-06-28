#!/usr/bin/env bash

directory=$(dirname "$0")

source "$directory/../config.sh"

pveum user token remove $TERRAFORM_USER $TERRAFORM_TOKEN &> /dev/null
pveum group delete $TERRAFORM_GROUP &> /dev/null
pveum user delete $TERRAFORM_USER &> /dev/null

mv /etc/apt/sources.list.d/pve-enterprise.sources.bak /etc/apt/sources.list.d/pve-enterprise.sources || true &> /dev/null
rm /etc/apt/sources.list.d/proxmox.sources