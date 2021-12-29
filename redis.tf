resource kubernetes_service redis {
  count = var.ignore ? 0 : 1

  metadata {
    name      = local.fullname
    namespace = var.namespace

    annotations = var.gke_neg ? {
      "cloud.google.com/neg-status" = ""                             # Eliminates Terraform diff
      "cloud.google.com/neg"        = jsonencode({ ingress = true }) # Eliminates Terraform diff
    } : {}

    labels = {
      "app.kubernetes.io/name"    = local.fullname
      "app.kubernetes.io/part-of" = "redis"
    }
  }

  spec {
    selector = {
      "app.kubernetes.io/component" = "redis"
      "app.kubernetes.io/instance"  = local.instance
      "app.kubernetes.io/part-of"   = local.part_of
    }

    port {
      port        = 6379
      name        = "redis"
      target_port = 6379
    }
  }

  lifecycle {
    ignore_changes = [
      metadata.0.annotations["cloud.google.com/neg-status"]
    ]
  }
}

resource kubernetes_deployment redis {
  count = var.ignore ? 0 : 1

  metadata {
    name      = local.fullname
    namespace = var.namespace

    labels = {
      "app.kubernetes.io/component" = "redis"
      "app.kubernetes.io/instance"  = local.instance
      "app.kubernetes.io/part-of"   = local.part_of
      "app.kubernetes.io/version"   = var.app_version
    }
  }

  spec {
    replicas = var.replicas_count

    selector {
      match_labels = {
        "app.kubernetes.io/component" = "redis"
        "app.kubernetes.io/instance"  = local.instance
        "app.kubernetes.io/part-of"   = local.part_of
      }
    }

    template {
      metadata {
        labels = {
          "app.kubernetes.io/component" = "redis"
          "app.kubernetes.io/instance"  = local.instance
          "app.kubernetes.io/part-of"   = local.part_of
        }
      }

      spec {
        active_deadline_seconds          = 0
        automount_service_account_token  = false
        dns_policy                       = "ClusterFirst"
        enable_service_links             = false
        host_ipc                         = false
        host_network                     = false
        host_pid                         = false
        node_selector                    = {}
        restart_policy                   = "Always"
        share_process_namespace          = false
        termination_grace_period_seconds = 30
        container {
          args                     = var.instance_invocation_args
          command                  = []
          image                    = local.image
          name                     = "redis"
          image_pull_policy        = "Always"
          stdin                    = false
          stdin_once               = false
          termination_message_path = "/dev/termination-log"
          tty                      = false

          resources {
            requests = local.resource_requests
            limits   = local.resource_limits
          }
        }
      }
    }
  }
}
