terraform {
  required_version = "~> 1.3.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.49.0"
    }
  }
}

provider "google" {
  project = "my-project-id"
  region  = "us-central1"
}