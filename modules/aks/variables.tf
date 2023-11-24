variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
  default     = 3
}

variable "msi_id" {
  type        = string
  description = "The Managed Service Identity ID. Set this value if you're running this example using Managed Identity as the authentication method."
  default     = null
}

variable "username" {
  type        = string
  description = "The admin username for the new cluster."
  default     = "azureadmin"
}

variable "k8s_version" {
  type        = string
  description = "The Kubernetes version to use for the new AKS cluster."
  default     = "1.26"  
}


variable "hub-vnet-id" {
  type = string
  description = "value of hub-vnet-id"
}

variable "environment" {
  type = string  
  description = "This variable defines the Environment"  
  default = "dev2"
}