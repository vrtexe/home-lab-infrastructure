#!/usr/bin/env bash

DEBUG=$([[ " $* " == *" --debug "* ]] && echo "true" || echo "false")

CONFIG_FILE="config.sh"

directory=$(dirname "$0");
source $directory/$CONFIG_FILE ""

user=$PROXMOX_USER
host=${1:-$PROXMOX_HOST}
scripts="${@:2}"

if [ ! -v USER_PASSWORD ]; then
  read -sp "Enter remote password: " USER_PASSWORD
  echo "" >&2
fi

PROXMOX_HOST="$user@$host"
HOST_PATH="$PROXMOX_HOST:$PROXMOX_DEST_DIR/"

function log() {
  if [ "$DEBUG" = "true" ]; then
    echo "$1"
  fi
}

function remote_copy() {
  local source=$1
  local destination=$2
  log "Copying $source to $destination"
  sshpass -p $USER_PASSWORD scp $source $destination
}

function remote_copy_dir() {
  local source=$1
  local destination=$2
  log "Copying $source to $destination"
  sshpass -p $USER_PASSWORD scp -r $source $destination
}

function remote_exec() {
  local file=$1
  log "Executing $PROXMOX_DEST_DIR/$file on remote host"
  sshpass -p $USER_PASSWORD ssh $PROXMOX_HOST "$PROXMOX_DEST_DIR/$file"
}

mkdir -p $directory/$LOCAL_TOKEN_DIRECTORY

remote_copy $directory/$CONFIG_FILE $HOST_PATH
remote_copy $directory/$PROXMOX_BOOTSTRAP_SCRIPT $HOST_PATH
remote_copy_dir $directory/$PROXMOX_SCRIPTS_DIR $HOST_PATH

remote_exec $PROXMOX_BOOTSTRAP_SCRIPT

remote_copy $PROXMOX_HOST:$PROXMOX_TOKEN_DIRECTORY/$TERRAFORM_SECRET_FILE $LOCAL_TOKEN_DIRECTORY/$TERRAFORM_SECRET_FILE
