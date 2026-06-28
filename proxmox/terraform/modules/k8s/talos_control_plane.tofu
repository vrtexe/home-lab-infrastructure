
data "talos_machine_configuration" "control_plane" {
  cluster_name       = var.cluster_name
  cluster_endpoint   = var.cluster_endpoint
  machine_type       = "controlplane"
  machine_secrets    = talos_machine_secrets.this.machine_secrets
  kubernetes_version = var.kubernetes_version
}

resource "talos_machine_configuration_apply" "control_plane" {
  depends_on                  = [data.helm_template.cilium]
  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.control_plane.machine_configuration
  for_each                    = var.cluster_data.control_planes
  node                        = each.value.host
  config_patches = [
    templatefile("${path.module}/templates/control_plane_config.tftpl", {
      network_hostname       = each.value.name
      install_disk           = var.cluster_data.install_disk
      install_image          = var.cluster_image_url
      vip_shared_ip          = var.cluster_vip_shared_ip
      node_address           = each.value.address
      node_gateway           = each.value.gateway
      kubelet_node_ip_subnet = each.value.address
    }),
    yamlencode({
      cluster = {
        inlineManifests = [
          {
            name     = "cilium-cni"
            contents = data.helm_template.cilium.manifest
          }
        ]
      }
    })
  ]
}
