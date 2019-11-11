variable "app_version" {
  description = "Version of Docker image to spin up"
  default = "latest"
}

variable "client_name" {
  description = "Name of Client"
}

variable "cloud_provider" {
  description = "Place where this runs"
  default = "gcp"
}

variable "environment" {
  description = "Environment to run in"
}

variable "replicas_count" {
  description = "Number of replicas to run on k8s cluster"
  default = 1
}
variable "namespace" {
  description = "The ID for the namespace this environment lives in - override with client name for multi-tennanted clients"
  default = "default"
}
