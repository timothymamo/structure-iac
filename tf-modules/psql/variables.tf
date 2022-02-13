variable "environment" {
  description = "Development environment. Use either dev/acc/prd"
  type        = string

  validation {
    condition     = contains(["dev", "acc", "prd"], var.environment)
    error_message = "The environment value must be a string and one of dev, acc or prod."
  }
}

variable "db_name" {
  description = "The name of the PSQL instance."
  type        = string
}

variable "tier" {
  description = "The CloudSQL instance tier to use. If left blank will use db-n1-standard-4 for backend database and db-f1-micro for all others."
  type        = string
  default     = ""
}