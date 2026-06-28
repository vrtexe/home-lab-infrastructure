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

variable "cilium_repository" {
  description = "Repository of Cilium to install"
  type        = string
  default     = "oci://quay.io/cilium/charts"
}

variable "cilium_name" {
  description = "Name of the Cilium release"
  type        = string
  default     = "cilium"
}

variable "cilium_chart" {
  description = "Chart name of Cilium to install from the repository"
  type        = string
  default     = "cilium"
}

variable "cilium_version" {
  description = "Version of Cilium to install"
  type        = string
  default     = "1.19.5"
}

variable "cilium_config" {
  type = object({
    name       = optional(string, "cilium")
    chart      = optional(string, "cilium")
    version    = optional(string, "1.19.5")
    repository = optional(string, "oci://quay.io/cilium/charts")
    operator = optional(object({
      replicas = optional(number, 1)
      }), {
      replicas = 1
    })
    kubernetes = optional(object({
      control_plane_ip   = optional(string, "192.168.100.20")
      control_plane_port = optional(string, "6443")
      }), {
      control_plane_ip   = "192.168.100.20"
      control_plane_port = "6443"
    })
  })

  default = {}
}
