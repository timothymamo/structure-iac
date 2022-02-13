module "gke" {
    source = "../../../tf-modules/gke"

    environment = "dev"
    regional    = false
}

output "module" {
    value   = module.gke
}