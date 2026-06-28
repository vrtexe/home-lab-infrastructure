terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.110.0"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "~> 0.11.0"
    }
    helm = {
      source  = "opentofu/helm"
      version = "~> 3.2.0"
    }
  }
}
