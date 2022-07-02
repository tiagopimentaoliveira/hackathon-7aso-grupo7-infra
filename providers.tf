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
  project = var.project_id
  region  = var.region
  
}

provider "google-beta" {
   project = var.project_id
  region  = var.region
  
}