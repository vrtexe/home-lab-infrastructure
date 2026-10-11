#!/usr/bin/env bash

environment="env/main.tfvars"

tofu apply \
  -var-file="proxmox_secret.tfvars" \
  -var-file="github_secret.tfvars" \
  -var-file="cloudflare_secret.tfvars" \
  -var-file="$environment"