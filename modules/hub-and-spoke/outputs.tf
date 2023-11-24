output "hub-vnet-id" {
    value = azurerm_virtual_network.hub-vnet.id     
}

output "vnet-spoke01-id" {
  value = azurerm_virtual_network.spoke1-vnet.id
}

output "subnet-spoke01-workload-id" {
  value = azurerm_subnet.spoke1-workload.id
  
}

output "vnet-spoke02-id" {
  value = azurerm_virtual_network.spoke2-vnet.id
}

output "subnet-spoke02-workload-id" {
  value = azurerm_subnet.spoke2-workload.id
}
