resource "google_project_service" "run_api" {
  service = "run.googleapis.com"

  disable_on_destroy = true
}


resource "google_cloud_run_service" "playlist" {
  name     = "playlist"
  location = "us-central1"
  template {
    spec {
      containers {
        image = "gcr.io/terraform-cr/webapp"
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
}
# Create public access
data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

# Return service URL
output "url" {
  value = "${google_cloud_run_service.playlist.status[0].url}"
}

resource "google_artifact_registry_repository" "my-repo" {
  provider = google-beta

  location = "us-central1"
  repository_id = var.project_id
  description = "Image DOCKER"
  format = "DOCKER"
}