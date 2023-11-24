
output "hub-vnet-id" {
    value = module.hub-and-spoke.hub-vnet-id 
}

output "vnet-spoke01-id" {
  value = module.hub-and-spoke.vnet-spoke01-id
}

output "subnet-spoke01-workload-id" {
  value = module.hub-and-spoke.subnet-spoke01-workload-id
  
}

output "vnet-spoke02-id" {
  value = module.hub-and-spoke.vnet-spoke02-id
}

output "subnet-spoke02-workload-id" {
  value = module.hub-and-spoke.subnet-spoke02-workload-id
}



output "aks_resource_group_name" {
  value = module.aks.resource_group_name
}

output "kubernetes_cluster_name" {
  value = module.aks.kubernetes_cluster_name
}

output "kube_config" {
  value = module.aks.kube_config
}


output "admin_password" {
  sensitive = true
  value     = module.vm.admin_password  
}
