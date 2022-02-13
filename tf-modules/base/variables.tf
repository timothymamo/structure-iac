variable "environment" {
  description = "Development environment. Use either dev/acc/prd"
  type        = string

  validation {
    condition     = contains(["dev", "acc", "prd"], var.environment)
    error_message = "The environment value must be a string and one of dev, acc or prd."
  }
}