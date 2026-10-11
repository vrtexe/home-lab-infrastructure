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
      values = optional(map(any), {})
      }), {
      name   = "argocd-apps"
      chart  = "argocd-apps"
      values = {}
    })
  })

  default = {}
}
