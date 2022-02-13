module "base" {
    source = "../../../tf-modules/base"

    environment = "prd"
}

output "module" {
    value   = module.base
}