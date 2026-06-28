#!/usr/bin/env bash


talosctl --nodes=192.168.100.21 --endpoints=192.168.100.20 --talosconfig ../.data/talos_config.yaml "${@}"