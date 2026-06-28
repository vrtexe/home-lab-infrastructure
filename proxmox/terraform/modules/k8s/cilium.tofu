data "helm_template" "cilium" {
  name             = var.cilium_config.name
  repository       = var.cilium_config.repository
  chart            = var.cilium_config.chart
  version          = var.cilium_config.version
  kube_version     = var.kubernetes_version
  namespace        = "kube-system"
  create_namespace = false

  values = [
    yamlencode({
      ipam = {
        mode = "kubernetes"
      }
      cgroup = {
        autoMount = {
          enabled = false
        }
        hostRoot = "/sys/fs/cgroup"
      }
      securityContext = {
        capabilities = {
          ciliumAgent = [
            "CHOWN",
            "KILL",
            "NET_ADMIN",
            "NET_RAW",
            "IPC_LOCK",
            "SYS_ADMIN",
            "SYS_RESOURCE",
            "DAC_OVERRIDE",
            "FOWNER",
            "SETGID",
            "SETUID"
          ],
          cleanCiliumState = [
            "NET_ADMIN",
            "SYS_ADMIN",
            "SYS_RESOURCE"
          ]
        }
      }

      operator = {
        replicas = var.cilium_config.operator.replicas
      }

      kubeProxyReplacement = true
      k8sServiceHost       = var.cilium_config.kubernetes.control_plane_ip
      k8sServicePort       = var.cilium_config.kubernetes.control_plane_port
    })
  ]
}
