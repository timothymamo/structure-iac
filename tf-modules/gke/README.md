# GKE Module

This Terraform module creates a GKE Cluster. The GKE cluster can be setup to be used a zonal or regional (default) cluster. By default the node pool machine type used is `e2-small`. For production environments the node pool deployed uses an `e2-medium` machine type. With the cluster, an nginx ingress-controller is also deployed.

## Inputs/Outputs

This part of the README is generated using [Terraform-docs](https://github.com/segmentio/terraform-docs). If you use [Pre-commit](https://pre-commit.com/), install the hooks (`pre-commit install`) and documentation will be generated automatically on commit whenever a `*.tf` file is changed.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |
| google | 3.72.0 |
| helm | 2.2.0 |
| kubernetes | 2.3.2 |

## Providers

| Name | Version |
|------|---------|
| google | 3.72.0 |
| helm | 2.2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | Development environment. Use either dev/acc/prd | `string` | n/a | yes |
| gke\_version | The minimum version of the kuberneets master to be applied. | `string` | `""` | no |
| regional | Sets wether the cluster being created is regional (default) or zonal. WARNING: This is a destructive change after cluster creation! | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_ca\_certificate | n/a |
| cluster\_endpoint | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->