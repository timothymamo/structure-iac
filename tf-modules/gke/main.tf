resource "google_project_service" "container" {
  service = "container.googleapis.com"
}

resource "google_container_cluster" "cluster" {

  ip_allocation_policy {}

  name = "${var.environment}"

  location = local.location

  remove_default_node_pool = true
  initial_node_count       = 1

  min_master_version = local.gke_version

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  maintenance_policy {
    daily_maintenance_window {
      start_time = "01:00" # GMT timezone
    }
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  depends_on = [google_project_service.container]
}

resource "google_container_node_pool" "node_pool_main" {
  name    = "nodepool-main-${var.environment}"
  cluster = google_container_cluster.cluster.name

  location = local.location

  initial_node_count = 1

  node_config {
    machine_type = var.environment == "prd" ? "e2-medium" : "e2-small"

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only",
    ]
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 2
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}


