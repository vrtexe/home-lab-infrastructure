#!/usr/bin/env bash

source config.sh

SCRIPT_DIRECTORY=$PROXMOX_DEST_DIR/$PROXMOX_SCRIPTS_DIR

for script in $SCRIPT_DIRECTORY/*; do
  if [[ $script != $SCRIPT_DIRECTORY/_* ]]; then
    echo "Running $script on $PROXMOX_HOST"
    $script
  else
    echo "Skipping $script"
  fi
done
