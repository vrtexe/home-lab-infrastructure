#!/usr/bin/env bash

environment="env/main.tfvars"

tofu destroy \
  -var-file="proxmox_secret.tfvars" \
  -var-file="$environment"