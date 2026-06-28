resource "proxmox_virtual_environment_vm" "worker_node_vm" {
  depends_on = [proxmox_download_file.linux_iso_image]
  name       = each.value.name_vm
  node_name  = var.proxmox_target_node
  tags       = ["kubernetes", "worker-node"]
  for_each   = var.cluster_data.workers

  agent {
    enabled = true
  }

  cpu {
    cores = coalesce(each.value.cpu, var.cluster_data.cpu)
    type  = "host"
  }

  boot_order = ["scsi0", "sata0", "net0"]

  memory {
    dedicated = coalesce(each.value.memory, var.cluster_data.memory)
    floating  = coalesce(each.value.memory, var.cluster_data.memory)
  }

  machine = "q35"
  bios    = "ovmf"

  cdrom {
    file_id   = proxmox_download_file.linux_iso_image.id
    interface = "sata0"
  }

  efi_disk {
    datastore_id      = "local-lvm"
    file_format       = "raw"
    type              = "4m"
    pre_enrolled_keys = false
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    file_format  = "raw"
    size         = coalesce(each.value.disk, var.cluster_data.disk)
    ssd          = true
  }

  operating_system {
    type = "l26"
  }

  network_device {
    bridge = "vmbr0"
    model  = "virtio"
  }

  initialization {
    ip_config {
      ipv4 {
        address = each.value.address
        gateway = each.value.gateway
      }
    }
  }
}

output "worker_node_vm" {
  value = proxmox_virtual_environment_vm.worker_node_vm
}
