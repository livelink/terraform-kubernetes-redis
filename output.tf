output service {
  value = local.fullname
}
output dns {
  value = "${local.fullname}.${var.namespace}.svc.cluster.local"
}
