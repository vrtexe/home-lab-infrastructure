terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
    kubernetes = {
      source = "opentofu/kubernetes"
    }
  }
}
