terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.27.0"
    }
  }
}

# Configura o Provider Google Cloud com o Projeto
provider "google" {
  project = "hackathon-7aso-grupo-07"
  region  = "us-west1"
  zone    = "us-west1-b"
}