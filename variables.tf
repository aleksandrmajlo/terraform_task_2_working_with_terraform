variable "resource_group_name" {
  description = "Name of the Azure resource group."
  type        = string

  validation {
    condition     = length(trimspace(var.resource_group_name)) > 0
    error_message = "resource_group_name must not be empty."
  }
}

variable "location" {
  description = "Azure region in which the resources will be created."
  type        = string

  validation {
    condition     = length(trimspace(var.location)) > 0
    error_message = "location must not be empty."
  }
}

variable "storage_account_name" {
  description = "Globally unique Azure Storage account name (3-24 lowercase letters and numbers)."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "storage_account_name must contain 3-24 lowercase letters and numbers only."
  }
}

variable "container_name" {
  description = "Name of the private blob container."
  type        = string

  validation {
    condition = (
      can(regex("^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$", var.container_name)) &&
      !can(regex("--", var.container_name))
    )
    error_message = "container_name must be 3-63 characters, use lowercase letters, numbers or single hyphens, and start and end with a letter or number."
  }
}

variable "blob_name" {
  description = "Name of the ZIP blob uploaded to the container."
  type        = string

  validation {
    condition     = length(trimspace(var.blob_name)) >= 1 && length(var.blob_name) <= 1024
    error_message = "blob_name must contain 1-1024 characters."
  }
}
