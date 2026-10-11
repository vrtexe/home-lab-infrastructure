resource "helm_release" "argocd" {
  name       = var.argocd_config.name
  repository = var.argocd_config.repository
  version    = var.argocd_config.version

  chart            = var.argocd_config.chart
  namespace        = var.argocd_config.namespace
  create_namespace = true

  values = [
    file("${path.module}/templates/argocd-values.yaml"),
    yamlencode(var.argocd_config.values)
  ]
}

resource "helm_release" "argocd-apps" {
  depends_on = [helm_release.argocd]
  name       = var.argocd_config.apps.name
  repository = var.argocd_config.apps.repository
  version    = var.argocd_config.apps.version

  chart            = var.argocd_config.apps.chart
  namespace        = var.argocd_config.apps.namespace
  create_namespace = false

  values = [
    file("${path.module}/templates/argocd-apps-values.yaml"),
    yamlencode(var.argocd_config.apps.values)
  ]
}

