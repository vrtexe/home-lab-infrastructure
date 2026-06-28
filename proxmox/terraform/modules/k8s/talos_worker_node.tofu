data "talos_machine_configuration" "worker_node" {
  cluster_name       = var.cluster_name
  cluster_endpoint   = var.cluster_endpoint
  machine_type       = "worker"
  machine_secrets    = talos_machine_secrets.this.machine_secrets
  kubernetes_version = var.kubernetes_version
}

resource "talos_machine_configuration_apply" "worker_node" {
  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.worker_node.machine_configuration
  for_each                    = var.cluster_data.workers
  node                        = each.value.host
  config_patches = [
    templatefile("${path.module}/templates/worker_node_config.tftpl", {
      network_hostname = each.value.name
      install_disk     = var.cluster_data.install_disk
      install_image    = var.cluster_image_url
      vip_shared_ip    = var.cluster_vip_shared_ip
      node_address     = each.value.address
      node_gateway     = each.value.gateway
    })
  ]
}
