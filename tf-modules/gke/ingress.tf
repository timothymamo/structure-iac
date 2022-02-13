resource "helm_release" "nginx_ingress" {
  name             = "nginx-ingress"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  version          = "3.27.0"
  create_namespace = true

  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "controller.publishService.enabled"
    value = "true"
  }

  set {
    name  = "controller.service.loadBalancerIP"
    value = data.google_compute_address.static_ip.address
  }

  set {
    name  = "defaultBackend.service.loadBalancerIP"
    value = data.google_compute_address.static_ip.address
  }

  set {
    name  = "controller.replicaCount"
    value = 3
  }

  set {
    name  = "controller.minAvailable"
    value = 1
  }

  depends_on = [google_container_node_pool.node_pool_main]
}