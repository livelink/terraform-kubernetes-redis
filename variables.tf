variable "app_version" {
  description = "Version of Docker image to spin up"
  default = "latest"
}

variable "client_name" {
  description = "Name of Client"
}

variable "environment" {
  description = "Environment to run in"
}

variable "service" {
  description = "Redis service to run"
  default = "generic"
}

variable "replicas_count" {
  description = "Number of replicas to run on k8s cluster"
  default = 1
}

variable "namespace" {
  description = "The ID for the namespace this environment lives in - override with client name for multi-tennanted clients"
  default = "default"
}

variable "ignore" {
  description = "whether to create these things"
  default = false
}

variable "part_of" {}
