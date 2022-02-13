data "google_client_config" "default" {}

data "google_compute_address" "static_ip" {
  name = "static-ip-${var.environment}"
}

data "google_container_engine_versions" "region" {
  location = "europe-west4"
}

data "google_container_engine_versions" "zone" {
  location = "europe-west4-a"
}