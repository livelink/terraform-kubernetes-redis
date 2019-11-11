terraform {
  backend "s3" {}
}

provider "aws" {
  region  = "eu-west-2"
  profile = "default"
}

data "terraform_remote_state" "k8s" {
  backend = "s3"

  config = {
    bucket = "livelink-terraform"
    key    = "infrastructure/k8s/${var.cloud_provider}/${var.environment}/${var.client_name}.tfstate"
    region = "eu-west-2"
  }
}

provider "kubernetes" {
  host                   = data.terraform_remote_state.k8s.outputs.host
  username               = data.terraform_remote_state.k8s.outputs.cluster_username
  password               = data.terraform_remote_state.k8s.outputs.cluster_password
  client_certificate     = base64decode(data.terraform_remote_state.k8s.outputs.client_certificate)
  client_key             = base64decode(data.terraform_remote_state.k8s.outputs.client_key)
  cluster_ca_certificate = base64decode(data.terraform_remote_state.k8s.outputs.cluster_ca_certificate)
}

data "terraform_remote_state" "client_google_project" {
  backend = "s3"
  config = {
    bucket = "livelink-terraform"
    key = "clients/${var.client_name}/terraform.tfstate"
    region = "eu-west-2"
  }
}

provider "google" {
  project = data.terraform_remote_state.client_google_project.project_ids[var.environment]
  region = data.terraform_remote_state.client_google_project.default_resource_location
  credentials = base64decode(data.terraform_remote_state.client_google_project.service_account_keys[var.environment])
}
