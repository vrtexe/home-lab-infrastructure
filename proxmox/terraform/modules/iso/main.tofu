locals {
  talos_image_config = merge(
    yamldecode(file("${path.module}/template/talos_image.yaml")),
    var.talos_image.config
  )
}
resource "talos_image_factory_schematic" "this" {
  schematic = yamlencode(local.talos_image_config)
}

data "talos_image_factory_urls" "this" {
  talos_version = var.talos_image.version
  schematic_id  = talos_image_factory_schematic.this.id
  platform      = var.talos_image.platform
  architecture  = var.talos_image.architecture
}

output "image_data" {
  value = data.talos_image_factory_urls.this
}

locals {
  test = data.talos_image_factory_urls.this.urls.iso_secureboot
}