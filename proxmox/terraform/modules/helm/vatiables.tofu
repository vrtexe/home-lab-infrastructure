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
