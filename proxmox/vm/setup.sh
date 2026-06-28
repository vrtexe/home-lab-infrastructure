#!/usr/bin/env bash

directory=$(dirname "$0")

source $directory/config.sh

$directory/execute.sh
$directory/../scripts/init-secrets.sh