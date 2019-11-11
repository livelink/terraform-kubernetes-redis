output service {
  value = kubernetes_service.svc-redis.metadata.0.name
}
output dns {
  value = "${kubernetes_service.svc-redis.metadata.0.name}.${var.namespace}.svc.cluster.local"
}
