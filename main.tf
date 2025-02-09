provider "google" {
  credentials = var.CREDENTIALS_GKE
  project     = "var.GCP_PROJECT_ID
  region      = var.GKE_REGION
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
  location = var.GKE_REGION

  initial_node_count = 2
  node_config {
    machine_type = "n1-standard-1"
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-node-pool"
  location   = var.GKE_REGION
  cluster    = google_container_cluster.primary.name
  initial_node_count = 2

  node_config {
    machine_type = "n1-standard-1"
  }
}

output "kubeconfig" {
  value = google_container_cluster.primary.endpoint
}


variable "GCP_PROJECT_ID" {
  description = "GCP Project ID"
  type        = string
}

variable "CREDENTIALS_GKE" {
  description = "Path to the JSON credentials file"
  type        = string
}

variable "GKE_REGION" {
  description = "GCP Region"
  default     = "us-east1"
}