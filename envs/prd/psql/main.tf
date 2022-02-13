module "psql" {
    source = "../../../tf-modules/psql"

    environment = "prd"
    db_name     = "psql"
}

output "module" {
    value   = module.psql
    sensitive = true
}