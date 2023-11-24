variable "name" {
  description = "Hostname for the VM."
  type        = string
  default = "VM01"
}

variable "subnet_id" {
  description = "Resource ID for a subnet."   
  type = string
}

variable "resource_group_name" {
  description = "Name for the resource group. Required."
  type        = string
}

//=============================================================

variable "size" {
  description = "Azure virtual machine size. Must support Gen 2."
  default     = "Standard_D2s_v3"
}

variable "location" {
  description = "Azure region."
  default     = "East US"
}

variable "tags" {
  description = "Map of tags for the resources created by this module."
  type        = map(string)
  default     = {}
}

//=============================================================

variable "admin_username" {
  description = "VM admin username."
  default     = "azureadmin"
}

variable "prefix" {
  type        = string
  default     = "win-vm-iis"
  description = "Prefix of the resource name"
}