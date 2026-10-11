provider "proxmox" {
  endpoint  = var.proxmox_server
  api_token = "${var.proxmox_token_id}=${var.proxmox_token_secret}"
  insecure  = true
}

provider "talos" {
}

locals {
  kube_client = module.k8s.kubernetes_client_configuration
}

# Only renders charts locally (helm_template), so it needs no cluster access
provider "helm" {
  alias = "template"
}

provider "helm" {
  kubernetes = {
    host                   = local.kube_client.host
    cluster_ca_certificate = base64decode(local.kube_client.ca_certificate)
    client_certificate     = base64decode(local.kube_client.client_certificate)
    client_key             = base64decode(local.kube_client.client_key)
  }
}

provider "kubernetes" {
  host                   = local.kube_client.host
  cluster_ca_certificate = base64decode(local.kube_client.ca_certificate)
  client_certificate     = base64decode(local.kube_client.client_certificate)
  client_key             = base64decode(local.kube_client.client_key)
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}