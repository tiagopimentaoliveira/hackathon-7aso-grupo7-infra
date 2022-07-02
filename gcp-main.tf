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
# Enable public access on Cloud Run service
resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.playlist.location
  project     = google_cloud_run_service.playlist.project
  service     = google_cloud_run_service.playlist.name
  policy_data = data.google_iam_policy.noauth.policy_data
}
# Return service URL
output "url" {
  value = "${google_cloud_run_service.playlist.status[0].url}"
}