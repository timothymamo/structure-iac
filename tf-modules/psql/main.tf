resource "google_project_service" "sqladmin" {
  service = "sqladmin.googleapis.com"
}

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "psql" {
  name                = "${var.db_name}-${var.environment}-${random_id.db_name_suffix.hex}"
  database_version    = "POSTGRES_11"
  deletion_protection = var.environment == "prd" ? true : false

  settings {
    tier            = var.tier != "" ? "db-n1-standard-4" : "db-f1-micro"
    disk_autoresize = true

    backup_configuration {
      enabled            = true
      binary_log_enabled = var.environment == "prd" ? true : false
    }

    location_preference {
      zone = "europe-west4-b"
    }

    ip_configuration {
      private_network = "projects/${data.google_client_config.default.project}/global/networks/default"
    }

    maintenance_window {
      day  = 7
      hour = 1
    }
  }

  depends_on = [
    google_service_networking_connection.private_vpc_connection_sql,
    google_project_service.sqladmin
  ]
}

resource "random_id" "db_name_replica_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "psql_replica" {
  count = var.environment == "prd" ? 1 : 0

  name                 = "${var.db_name}-${var.environment}-failover-${random_id.db_name_replica_suffix.hex}"
  database_version     = "POSTGRES_11"
  master_instance_name = google_sql_database_instance.psql.name

  replica_configuration {
    failover_target = true
  }

  settings {
    tier                   = google_sql_database_instance.psql.settings[0].tier
    disk_size              = 100
    disk_autoresize        = true
    crash_safe_replication = true

    location_preference {
      zone = "europe-west4-c"
    }

    database_flags {
      name  = "log_output"
      value = "FILE"
    }

    database_flags {
      name  = "slow_query_log"
      value = "on"
    }

    ip_configuration {
      private_network = "projects/${data.google_client_config.default.project}/global/networks/default"
    }
  }

  depends_on = [google_sql_database_instance.psql]
}

resource "google_sql_database" "psql" {
  name     = var.db_name
  instance = google_sql_database_instance.psql.name
  charset  = "utf8"
}

resource "random_password" "password" {
  length  = 32
  special = true
}

resource "google_sql_user" "users" {
  name     = "captain"
  instance = google_sql_database_instance.psql.name
  host     = "captain.com"
  password = random_password.password.result
}
