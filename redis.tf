resource kubernetes_service redis {
  count = var.ignore ? 0 : 1
  metadata {
    name = local.fullname
    namespace = var.namespace
  }

  spec {
    selector = {
      "app.kubernetes.io/component" = "redis"
      "app.kubernetes.io/instance" = local.instance
      "app.kubernetes.io/part-of" = local.part_of
    }

    port {
      port = 6379
      name = "redis"
      target_port = 6379
    }
  }
}

resource kubernetes_deployment redis {
  count = var.ignore ? 0 : 1
  metadata {
    name = local.fullname
    namespace = var.namespace

    labels = {
      "app.kubernetes.io/component" = "redis"
      "app.kubernetes.io/instance" = local.instance
      "app.kubernetes.io/part-of" = local.part_of
      "app.kubernetes.io/version" = var.app_version
    }
  }

  spec {
    replicas = var.replicas_count

    selector {
      match_labels = {
        "app.kubernetes.io/component" = "redis"
        "app.kubernetes.io/instance" = local.instance
        "app.kubernetes.io/part-of" = local.part_of
      }
    }

    template {
      metadata {
        labels = {
          "app.kubernetes.io/component" = "redis"
          "app.kubernetes.io/instance" = local.instance
          "app.kubernetes.io/part-of" = local.part_of
        }
      }

      spec {
        container {
          image = local.image
          name  = "redis"
        }
      }
    }
  }
}
