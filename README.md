# Terraform Code - GCP Infrastructure

This directory holds the Terraform code that enables the deployment of a GKE cluster and Postgres CloudSQL. These modules create a layered setup that helps with setting up infrastructure that is predictable, easy to manage, reproducible, and easy to extend.

**NOTE: This may cost money if you are out of credits.**

### Requirements

* [terraform](https://www.terraform.io/downloads.html)

## Environment Setup

To setup an environment, create a directory for the environment with the modules you wish to deploy. Example [`dev`](envs/dev) and ['prd`](envs/prd) environment has been created. Each module within an environment will follow a basic structure with 3 files:

* backend.tf - Specifies the bucket where th terraform state file is stored remotely.
* main.tf - References the module to deploy and any required variables (each module has a README specifying the required/optional variables).
* provider.tf - Specifies google provider variables (project, zone, region).

An example `main.tf` file for the `psql` module is shown below:

```tf
module "psql" {
    source = "../../../tf-modules/psql"

    environment = "dev"
    db_name     = "psql"
}

output "module" {
    value   = module.psql
    sensitive = true
}
```

Once the files have been setup for each module, within the environment module created run the following `terraform` commands to spin up the GCP infrastructure (*N.B. Don't forget to setup your project and remote bucket*):

```bash
terraform init
terraform plan # (skip if you want to apply immediately)
terraform apply # (--auto-approve if you're feeling adventures)
```

Once you have used your infrastructure and don't need it anymore, don't forget to destroy it (so that you don't incur unwanted costs):

```bash
terraform destroy # (--auto-approve if you're feeling confident)
```

## Deployment Sequence

As the modules are setup in a layered setup the deployment sequence is important. For the current solution the deployment sequence should start with the deployment of the `base` module and after the `gke` and `psql` modules in parallel.

## Module documentation

* Each module subdirectory has its own `README.md` file containing basic information on the module.
* Inputs and Outputs are automatically documented using pre-commit hook in these `README.md` files.
  * To automatically create the documentation you need to install the hooks as described below and add the following text within the `README.md` file:

  ```md
  <!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
  <!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
  ```

## Hooks

Install `pre-commit` and `terraform-docs` (on MacOS, Homebrew has formulae for both).
You can install the pre-commit hooks by running `pre-commit install`.

## Possible Improvements

* Create multiple users with varying degrees of permissions to connect to the Postgres Database.
* Deploy k8s `configmaps` and `secrets` via terraform that reference information to the Postgres Database (host, users and passwords, etc).
* Deploy via GitHub Actions
