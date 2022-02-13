data "google_client_config" "default" {}

# Base APIs required to work with GCP.
resource "google_project_service" "cloudresourcemanager" {
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_compute_address" "static_ip" {
  name   = "static-ip-${var.environment}"
  region = data.google_client_config.default.region
}

# This sets up a Cloud NAT (https://cloud.google.com/nat/) for the default network so that the
# Kubernetes cluster can be run in a private setup but still have internet access.
resource "google_compute_router" "router" {
  name    = "router-${var.environment}"
  region  = data.google_client_config.default.region
  network = "default"

  depends_on = [
    google_project_service.cloudresourcemanager
  ]
}

resource "google_compute_router_nat" "nat" {
  name                               = "router-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
