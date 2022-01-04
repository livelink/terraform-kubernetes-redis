variable app_version {
  description = "Version of Docker image to spin up"
  default     = "latest"
}

variable client_name {
  description = "Name of Client"
}

variable environment {
  description = "Environment to run in"
}

variable service {
  description = "Redis service to run"
  default     = "generic"
}

variable replicas_count {
  description = "Number of replicas to run on k8s cluster"
  default     = 1
}

variable namespace {
  description = "The ID for the namespace this environment lives in - override with client name for multi-tennanted clients"
  default     = "default"
}

variable ignore {
  description = "whether to create these things"
  default     = false
}

variable part_of {}

locals {
  resource_limits = {
    cpu    = try(var.resource_limits["cpu"], "1")
    memory = try(var.resource_limits["memory"], "1Gi")
  }

  resource_requests = {
    cpu    = try(var.resource_requests["cpu"], "0.1")
    memory = try(var.resource_requests["memory"], "128Mi")
  }
}

variable resource_limits {
  default = {}
}

variable resource_requests {
  default = {}
}

variable instance_invocation_args {
  default = []
}

variable gke_neg {
  description =<<EOF
Handle GKE NEG auto annotations.
https://cloud.google.com/kubernetes-engine/docs/how-to/container-native-load-balancing
EOF
  default = false
}
