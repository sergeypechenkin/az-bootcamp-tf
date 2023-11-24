# outputs for windows-aad module
/*
output "name" {
  value = azurerm_windows_virtual_machine.vm.name
}

output "id" {
  value = azurerm_windows_virtual_machine.vm.id
}

output "private_ip_address" {
  value = azurerm_windows_virtual_machine.vm.private_ip_address
}

output "identity" {
  value = one(azurerm_windows_virtual_machine.vm.identity)
}

*/
output "admin_password" {
  sensitive = true
  value     = azurerm_windows_virtual_machine.vm.admin_password
}

/*
# outputs for aks module

output "k8s-cluster-name" {
  value = azurerm_kubernetes_cluster.k8s.name
}


# outputs for hub-and-spoke module

output "hub-vnet-id" {
  value = azurerm_virtual_network.hub-vnet.id
}

output "spoke-01-subnet-id" {
  value = azurerm_subnet.spoke-01-subnet.id
}

output "spoke-02-subnet-id" {
  value = azurerm_subnet.spoke-02-subnet.id
}

output "spoke-01-vnet-id" {
  value = azurerm_virtual_network.spoke-01-vnet.id
}

output "spoke-02-vnet-id" {
  value = azurerm_virtual_network.spoke-02-vnet.id
}

output "hub-vnet-name" {
  value = azurerm_virtual_network.hub-vnet.name
}

output "spoke-01-vnet-name" {
  value = azurerm_virtual_network.spoke-01-vnet.name
} 

output "spoke-02-vnet-name" {
  value = azurerm_virtual_network.spoke-02-vnet.name
}

output "hub-vnet-rg" {
  value = azurerm_resource_group.rg-vnet-hub.name
}

output "spoke-01-vnet-rg" {
  value = azurerm_resource_group.rg-spoke-01-vnet.name
}
*/