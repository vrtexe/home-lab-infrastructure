resource "proxmox_download_file" "linux_iso_image" {
  node_name    = var.proxmox_target_node
  content_type = "iso"
  datastore_id = "local"

  overwrite_unmanaged = true
  url       = var.linux_iso_image_url
  file_name = var.linux_iso_image_filename
}
