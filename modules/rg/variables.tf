variable "rg_name" {
    type = string
    description = "The name for the resource group"
}

variable "location" {
    type = string
    description = "The location for the deployment"
    default = "North Europe"
}