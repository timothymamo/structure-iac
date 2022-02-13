module "psql" {
    source = "../../../tf-modules/psql"

    environment = "dev"
    db_name     = "psql"
}

output "module" {
    value   = module.psql
    sensitive = true
}