variable "proxmox_token_id" {
  description = "Proxmox API token ID"
  type        = string
  sensitive   = true
}

variable "proxmox_token_secret" {
  description = "Proxmox API token secret"
  type        = string
  sensitive   = true
}

variable "proxmox_server" {
  description = "Proxmox server URL"
  type        = string
  default     = "https://192.168.100.2:8006"
}

variable "proxmox_target_node" {
  description = "Proxmox target node"
  type        = string
  default     = "pve"
}

variable "talos_image" {
  description = "Talos image configuration"
  type = object({
    version      = optional(string, "v1.13.4")
    platform     = optional(string, "nocloud")
    architecture = optional(string, "amd64")
    config       = optional(map(any), {})
  })
  default = {}
}

variable "cluster_vip_shared_ip" {
  default = "192.168.100.20"
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

variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = ".data/kubeconfig.yaml"
}

variable "talos_config_path" {
  description = "Path to the Talos config file"
  type        = string
  default     = ".data/talos_config.yaml"
}

variable "cluster_data" {
  description = "Cluster data for Talos control plane configuration"
  type = object({
    cpu           = number
    memory        = number
    disk          = number
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
