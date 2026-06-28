# variable "talos_image_version" {
#   description = "Talos image version"
#   type        = string
#   default     = "v1.13.4"
# }

# variable "talos_image_config" {
#   description = "Talos image configuration"
#   type        = object(any)
#   default     = {}
# }


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
