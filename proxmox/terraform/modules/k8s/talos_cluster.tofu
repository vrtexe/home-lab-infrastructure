resource "talos_machine_secrets" "this" {}

locals {
  talos_endpoints = concat([var.cluster_vip_shared_ip], [for k, v in var.cluster_data.control_planes : v.host])
}

data "talos_client_configuration" "this" {
  cluster_name         = var.cluster_name
  client_configuration = talos_machine_secrets.this.client_configuration
  endpoints            = local.talos_endpoints
}

resource "talos_machine_bootstrap" "this" {
  depends_on = [talos_machine_configuration_apply.control_plane]

  client_configuration = talos_machine_secrets.this.client_configuration
  node                 = [for k, v in var.cluster_data.control_planes : v.host][0]
}



resource "talos_cluster_kubeconfig" "this" {
  # depends_on = [data.talos_cluster_health.talos_health]
  depends_on           = [talos_machine_bootstrap.this]
  client_configuration = talos_machine_secrets.this.client_configuration
  node                 = [for k, v in var.cluster_data.control_planes : v.host][0]
  endpoint             = var.cluster_vip_shared_ip
}

data "talos_cluster_health" "talos_health" {
  depends_on = [talos_machine_bootstrap.this]

  lifecycle {
    enabled = var.health_check
  }

  client_configuration = data.talos_client_configuration.this.client_configuration
  control_plane_nodes  = [for k, v in var.cluster_data.control_planes : v.host]
  worker_nodes         = [for k, v in var.cluster_data.workers : v.host]

  endpoints = local.talos_endpoints

  timeouts = {
    read = "3m"
  }
}
