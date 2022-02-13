# Base Module

The base module is used to setup initialization of Cloud Resource Manager service api as well as base networking for other modules to make sue of.

## Inputs/Outputs
This part of this README is generated using [Terraform-docs](https://github.com/segmentio/terraform-docs). If you use [Pre-commit](https://pre-commit.com/), install the hooks (`pre-commit install`) and documentation will be generated automatically on commit whenever a `*.tf` file is changed.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |
| google | 3.72.0 |

## Providers

| Name | Version |
|------|---------|
| google | 3.72.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | Development environment. Use either dev/acc/prd | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cloudresourcemanager | Cloud Resource Manager API which is enabled to manage APIs |
| ingress\_static\_ip | Static IP address for the ingress controller |
| nat | NAT router enabling internet access to private subnets/clusters |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->