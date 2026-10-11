variable "control_plane_ip" {
  description = "IP address of the Talos control plane"
  type        = string
  default     = "192.168.100.20"
}

variable "control_plane_port" {
  description = "Port of the Talos control plane"
  type        = string
  default     = "6443"
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token for authentication"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID for the domain"
  type        = string
  sensitive   = true
}

variable "cloudflare_account_id" {
  description = "Cloudflare Account ID"
  type        = string
  sensitive   = true
}

variable "argocd_config" {
  type = object({
    name       = optional(string, "argo-cd")
    chart      = optional(string, "argo-cd")
    version    = optional(string, "10.1.0")
    repository = optional(string, "oci://ghcr.io/argoproj/argo-helm")
    namespace  = optional(string, "argocd")
    values     = optional(map(any), {}),
    apps = optional(object({
      name       = optional(string, "argocd-apps")
      chart      = optional(string, "argocd-apps")
      version    = optional(string, "2.0.5")
      repository = optional(string, "oci://ghcr.io/argoproj/argo-helm")
      namespace  = optional(string, "argocd")
      values     = optional(map(any), {})
      }), {
      name   = "argocd-apps"
      chart  = "argocd-apps"
      values = {}
    })
  })

  default = {}
}
