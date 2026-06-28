resource "proxmox_virtual_environment_vm" "control_plane_vm" {
  depends_on = [proxmox_download_file.linux_iso_image]
  name       = each.value.name_vm
  node_name  = var.proxmox_target_node
  for_each   = var.cluster_data.control_planes

  agent {
    enabled = true
  }

  cpu {
    cores = coalesce(each.value.cpu, var.cluster_data.cpu)
    type  = "host"
  }

  boot_order = ["scsi0", "ide3", "net0"]

  memory {
    dedicated = coalesce(each.value.memory, var.cluster_data.memory)
    floating  = coalesce(each.value.memory, var.cluster_data.memory)
  }

  bios = "ovmf"

  cdrom {
    file_id = proxmox_download_file.linux_iso_image.id
  }

  efi_disk {
    datastore_id      = "local-lvm"
    file_format       = "raw"
    pre_enrolled_keys = true
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    file_format  = "raw"
    size         = coalesce(each.value.disk, var.cluster_data.disk)
    ssd          = true
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

output "control_plane_vm" {
  value = proxmox_virtual_environment_vm.control_plane_vm
}