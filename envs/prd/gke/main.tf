module "gke" {
    source = "../../../tf-modules/gke"

    environment = "prd"
    regional    = true
}

output "module" {
    value   = module.gke
}