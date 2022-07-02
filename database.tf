resource "google_sql_database" "database" {
  name     = "playlistDB"
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_database_instance" "instance" {
  name             = "playlistDB"
  region           = "us-central1"
  database_version = "MYSQL_8_0"
  settings {
    tier = "db-f1-micro"
  }

  deletion_protection  = "true"
}

resource "google_sql_user" "users" {
  name     = "playuser"
  instance = google_sql_database_instance.instance.name
  host     = "localhost"
  password = "123456"
}