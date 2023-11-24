variable "tenant_id" {
  type = string
  default = "null"
}

variable "subscription_id" {
  type = string
  default = "null"
}

variable "location" {
    description = "Azure region"
    default = "northeurope"
}

variable "resource_group_name" {
    description = "Azure rsg name"
    default = "rg_tf_bootcamp"  
}

variable "tags" {
    type = map(string)
    default = {}  
}