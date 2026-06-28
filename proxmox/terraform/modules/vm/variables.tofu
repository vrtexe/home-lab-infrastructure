variable "proxmox_target_node" {
  description = "Proxmox target node"
  type        = string
  default     = "pve"
}

variable "linux_iso_image_filename" {
  description = "Filename of the Linux ISO image for initially booting the VM"
  type        = string
}

variable "linux_iso_image_url" {
  description = "URL to the Linux ISO image"
  type        = string
}

variable "cluster_image_url" {
  description = "URL to the Talos cluster installer image"
  type        = string
}

variable "cluster_data" {
  description = "Cluster data for Talos control plane configuration"
  type = object({
    cpu          = optional(number)
    memory       = optional(number)
    disk         = optional(number)
    install_disk = string
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
