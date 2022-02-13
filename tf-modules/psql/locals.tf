locals {

  # Currently the labels argument is only supported in the google-beta provider
  # Even though having labels is considered good practice, enabling the beta provider only for this optiotn seems a bit of an overkill
  # Will leave this here for now will not be used until the labels argument is moved to GA
  default_labels = {
    environment = var.environment
  }
}