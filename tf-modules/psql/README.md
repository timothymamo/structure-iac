# SQL module

The SQL module is configured with;

* [Replication for High Availability](https://cloud.google.com/sql/docs/mysql/replication/) to a read replica, for `production` environment.
* A random suffix for the database name. In GCP, a name can not be used for a week after a database is destroyed.
* A Database user `captain` which can be used as a *"supersuer"* in setting up schemas, other users, etc, during the migration stage.

## Inputs/Outputs

This part of this README is generated using [Terraform-docs](https://github.com/segmentio/terraform-docs). If you use [Pre-commit](https://pre-commit.com/), install the hooks (`pre-commit install`) and documentation will be generated automatically on commit whenever a `*.tf` file is changed.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |
| google | 3.72.0 |
| random | 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| google | 3.72.0 |
| random | 3.1.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| db\_name | The name of the PSQL instance. | `string` | n/a | yes |
| environment | Development environment. Use either dev/acc/prd | `string` | n/a | yes |
| tier | The CloudSQL instance tier to use. If left blank will use db-n1-standard-4 for backend database and db-f1-micro for all others. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| captain\_password | The randomly generated password for the PSQL user captain |
| psql\_connection | The connection name of the instance to be used in connection strings |
| psql\_link | The URI of the PSQL created resource |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->