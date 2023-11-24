variable "location" {
    type = string
    description = "Location of the network"
    default     = "eastus"
}

variable "rg-vnet-hub" {
  type = string
  description = "Resourcegroup of the hub"
  default = "rg-hub-vnet"
}

variable "vnet-hub-name" {
    type = string
    description = "Name of the Virtual Network hub"
    default = "hub"
}

variable "vnet-spoke-01-name" {
  type = string
  description = "Name of the spoke 01"
  default = "spoke-01"
}

variable "vnet-spoke-02-name" {
  type = string
  description = "Name of the spoke 02"
  default = "spoke-02"
}

variable "rg-spoke-01-vnet" {
  type = string
  description = "Name of the resource group of spoke 01"
  default = "rg-spoke-01-vnet"
}


variable "rg-spoke-02-vnet" {
  type = string
  description = "Name of the resource group of spoke 02"
  default = "rg-spoke-02-vnet"
}

variable "rgKV" {
  type = string
  description = "Name of the existing resource group of the key vault"  
}

variable "kv" {
  type = string
  description = "Name of the existing key vault"  
}

variable "kvsecret" {
  type = string
  description = "Name of the existing key vault secret"  
  
}