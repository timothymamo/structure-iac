locals {

  # Currently the labels argument is only supported in the google-beta provider
  # Even though having labels is considered good practice, enabling the beta provider only for this optiotn seems a bit of an overkill
  # Will leave this here for now will not be used until the labels argument is moved to GA
  default_labels = {
    environment = var.environment
  }

  location = var.regional ? "europe-west4" : "europe-west4-a"

  regional_gke_version = data.google_container_engine_versions.region.release_channel_default_version["REGULAR"]
  zonal_gke_version    = data.google_container_engine_versions.zone.release_channel_default_version["REGULAR"]

  setup_gke_version = var.regional ? local.regional_gke_version : local.zonal_gke_version

  gke_version = var.gke_version == "" ? local.setup_gke_version : var.gke_version
}
