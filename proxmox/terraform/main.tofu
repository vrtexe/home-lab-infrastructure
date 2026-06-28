module "iso" {
  source = "./modules/iso"
  providers = {
    talos = talos
  }

  talos_image = var.talos_image
}

locals {
  linux_iso_image_filename = "talos-linux-${module.iso.image_data.talos_version}-${module.iso.image_data.platform}-${module.iso.image_data.architecture}.iso"
  linux_iso_image_url      = module.iso.image_data.urls.iso_secureboot
  cluster_image_url        = module.iso.image_data.urls.installer_secureboot
}

module "vm" {
  source     = "./modules/vm"
  depends_on = [module.iso]
  providers = {
    proxmox = proxmox
  }

  proxmox_target_node      = var.proxmox_target_node
  linux_iso_image_filename = local.linux_iso_image_filename
  linux_iso_image_url      = local.linux_iso_image_url
  cluster_image_url        = local.cluster_image_url
  cluster_data             = var.cluster_data
}

module "k8s" {
  source     = "./modules/k8s"
  depends_on = [module.vm]
  providers = {
    talos = talos
    helm  = helm
  }

  kubernetes_version    = var.kubernetes_version
  cluster_vip_shared_ip = var.cluster_vip_shared_ip
  cluster_name          = var.cluster_name
  cluster_endpoint      = var.cluster_endpoint
  cluster_image_url     = local.cluster_image_url
  cluster_data          = var.cluster_data
}

module "helm" {
  source     = "./modules/helm"
  depends_on = [module.k8s]
  providers = {
    helm = helm
  }

  control_plane_ip = var.cluster_vip_shared_ip
}
