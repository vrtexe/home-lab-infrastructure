output "kubeconfig" {
  value     = module.k8s.kubeconfig
  sensitive = true
}

output "talosconfig" {
  value     = module.k8s.talosconfig
  sensitive = true
}

resource "local_sensitive_file" "talos_kubeconfig" {
  content  = module.k8s.kubeconfig
  filename = "${path.module}/${var.kubeconfig_path}"
}

resource "local_sensitive_file" "talosconfig" {
  content  = module.k8s.talosconfig
  filename = "${path.module}/${var.talos_config_path}"
}

resource "local_file" "talos_image_versions" {
  content  = jsonencode(module.iso.image_data)
  filename = "${path.module}/.data/talos_image.json"
}
