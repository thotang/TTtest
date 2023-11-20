
variable "environment" {
  type        = string
  description = "Environment (test / prod)"
  validation {
    condition = contains([
      "test",
      "prod",
    ], var.environment)
    error_message = "Valid options are test and prod."
  }
}

variable "location" {
  type        = string
  default     = "Norway East"
  description = "Azure region to deploy module to"
}

variable "sku" {
  type        = string
  description = "SKU that will be used by this Function App's Service Plan"
  default     = "P1v2"
}

variable "whitelisted_ips" {
  type        = list(object({ name = string, start_ip_address = string, end_ip_address = string }))
  description = "List of IP adress ranges to whitelist"
}

# variable "sql_sku" {
#   type        = string
#   description = "SKU that will be used on Azure SQL server"
# }

# variable "sql_connection" {
#   type        = object({ name = string, connection_string = string })
#   description = "Passwordless connection for Azure SQL server"
# }