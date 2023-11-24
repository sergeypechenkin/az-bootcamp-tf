resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.rg_name}"
  location = var.location
}