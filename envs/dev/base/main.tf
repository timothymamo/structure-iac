module "base" {
    source = "../../../tf-modules/base"

    environment = "dev"
}

output "module" {
    value   = module.base
}