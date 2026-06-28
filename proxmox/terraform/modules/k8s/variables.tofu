variable "cluster_vip_shared_ip" {
  default = "192.168.100.20"
}

variable "kubelet_node_ip_subnet" {
  default = "192.168.100.0/24"
}

variable "kubernetes_version" {
  type    = string
  default = "1.36.1"
}

variable "cluster_name" {
  type    = string
  default = "talos-cluster"
}

variable "cluster_endpoint" {
  type    = string
  default = "https://192.168.100.20:6443"
}

variable "health_check" {
  description = "Enable or disable health check"
  type        = bool
  default     = true
}

variable "cluster_image_url" {
  description = "URL to the Talos cluster installer image"
  type        = string
}

variable "cluster_data" {
  description = "Cluster data for Talos control plane configuration"
  type = object({
    cpu           = optional(number)
    memory        = optional(number)
    disk          = optional(number)
    install_disk  = string
    control_planes = map(object({
      host         = string
      name_vm      = string
      name         = string
      cpu          = optional(number)
      memory       = optional(number)
      disk         = optional(number)
      install_disk = optional(string)
      address      = string
      gateway      = string
    }))
    workers = map(object({
      host         = string
      name         = string
      name_vm      = string
      cpu          = optional(number)
      memory       = optional(number)
      disk         = optional(number)
      install_disk = optional(string)
      address      = string
      gateway      = string
    }))
  })
}
