provider "proxmox" {
  endpoint  = var.proxmox_server
  api_token = "${var.proxmox_token_id}=${var.proxmox_token_secret}"
  insecure  = true
}

provider "talos" {
}

provider "helm" {
  kubernetes = {
    config_path = "${path.module}/${var.kubeconfig_path}"
  }
}
