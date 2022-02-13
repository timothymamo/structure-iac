variable "environment" {
  description = "Development environment. Use either dev/acc/prd"
  type        = string

  validation {
    condition     = contains(["dev", "acc", "prd"], var.environment)
    error_message = "The environment value must be a string and one of dev, acc or prod."
  }
}

variable "gke_version" {
  description = "The minimum version of the kuberneets master to be applied."
  type        = string
  default     = ""

  validation {
    condition     = var.gke_version == "" || can(regex("^1.[0-9]{1,2}.[0-9]{1,2}$", var.gke_version))
    error_message = "The gke veriosn needs to be a string in the following format 1.xx.xx."
  }
}

variable "regional" {
  description = "Sets wether the cluster being created is regional (default) or zonal. WARNING: This is a destructive change after cluster creation!"
  type        = bool
  default     = true
}
