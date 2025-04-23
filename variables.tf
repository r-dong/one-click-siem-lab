variable "admin_username" {
  description = "Username for the Windows VM"
  type        = string
  default     = "localadmin"
}

variable "admin_password" {
  description = "Password for the Windows VM"
  type        = string
  sensitive   = true
}

variable "address_space" {
  default     = ["10.1.0.0/16"]
  description = "CIDR for the virtual network"
}

variable "location" {
  description = "Azure region to deploy to"
  type        = string
  default     = "eastus"
}

variable "project_name" {
  description = "Base name for resource group and other resources"
  type        = string
}

variable "subnet_prefix" {
  default     = ["10.1.1.0/24"]
  description = "CIDR for the subnet"
}

variable "vm_size" {
  description = "Type of VM"
  type        = string
  default     = "Standard_B2s"
}
