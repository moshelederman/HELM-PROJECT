provider "google" {
  credentials = "var.CREDENTIALS_GKE"
  project     = "var.GCP_PROJECT_ID"
  region      = "us-east1"
}

terraform {
  backend "s3" {
    bucket         = "moshe-terrarorm"
    key            = "gke/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

resource "google_container_cluster" "primary" {
  name     = "gke-cluster"
  location = "us-east1"

  initial_node_count = 2
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-node-pool"
  location   = "us-east1"
  cluster    = google_container_cluster.primary.name
  initial_node_count = 2

  node_config {
    machine_type = "n1-standard-1"
  }
}

output "kubeconfig" {
  value = google_container_cluster.primary.endpoint
}

#resource "local_file" "kubeconfig" {
#  filename = "${path.module}/kubeconfig.yaml"
#  content  = google_container_cluster.primary.endpoint
#}

variable "project" {
  description = "GCP Project ID"
}

variable "region" {
  description = "GCP Region"
  default     = "us-east1"
}