# Infrastructure as Code - Full deployment
<p align="center"> <img src="/img/az-bootcamp.png"> </p>
The purpose of this repository is to demonstrate how Infrastructure as Code (IaC) can be used with  Terraform. 

IaC is a concept in software development where the infrastructure of an application or system is described and managed by code. It allows developers to treat the infrastructure as part of the version control system, track changes and deploy the infrastructure automatically.

Terraform is a popular open source tool that is often used for IaC. It enables the creation, modification and versioning of infrastructure resources in various cloud environments as well as on-premises systems. Terraform uses a declarative language to describe the infrastructure and allows developers to organize and reuse code in modules.


:construction: The configuration files, modules and Terraform code have been created with the greatest possible care and have also been checked and tested several times. Nevertheless, it is possible that errors may occur. Therefore, please do not hesitate to take action and create a pull request.

## Requirements
The following requirements are needed:

- An Azure subscription
- An Azure Key Vault
    - To use these modules, an <b>Azure Key Vault</b> and a <b>certificate for the P2S VPN connection</b> are required. If both resources are not available or created before the deployment, the deployment will result in an error.
- VPN-Gateway certificate

### Tools
- Azure CLI
    - Please refer to the [install guide](https://docs.microsoft.com/cli/azure/install-azure-cli) for detailed install instructions.

- Terraform
    - [Download](https://developer.hashicorp.com/terraform/downloads?product_intent=terraform)
    - Please refer to the [install cli](https://developer.hashicorp.com/terraform/tutorials/azure-get-started/install-cli) for detailed install instruction.

- Visual Studio Code Extension "Terraform"
    - https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform

- Terraform specific
    - <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.6.0)
    - <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) (>= 1.10.0)
    - <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>= 3.79.0)
    - <a name="requirement_random"></a> [random](#requirement\_random) (>= 3.1.0)
    - <a name="requirement_time"></a> [time](#requirement\_time) (>= 0.9.1)

- Azure VPN Client
    - [Download](https://apps.microsoft.com/detail/azure-vpn-client/9NP355QT2SQB?hl=en-ch&gl=us)

- Kubernetes CLI
    - [Download kubectl](https://kubernetes.io/releases/download/)


## Create an Azure Key Vault
Azure Key Vault is a cloud service that provides a secure store for keys, secrets, and certificates.

Create a resource group for the Key Vault.
```azurecli-interactive
az group create --name "rgKV" --location "EastUS"
```

Create a Key Vault in the resource group from the previous step
```azurecli-interactive
az keyvault create --name "<your-unique-keyvault-name>" --resource-group "rgKV" --location "EastUS"
```


## Certificate for Point-to-site VPN connection
For detailed instructions on how to generate and export the certificate with PowerShell: [Install guide](https://learn.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-certificates-point-to-site)

<b>Note:</b> Don't forget to create a secret for the public key information of the root certificate in the newly created Key Vault.

The scripts in the [folder](/scripts/vpngw/) help you to create a self-signed certificate. These scripts are optional and can be used if required. If you do not wish to use them, you must follow the instructions and documentation.

## Modules
### Modules structure
All module has the same module components.
For example:
* Module-Example
    * ResourceGroup
    * StorageAccount
    * Virtual Network

Following Modules are called:
* hub-and-spoke
    * Source: [](/modules/hub-and-spoke/)
* aks
    * Source: [](/modules/aks/)
* vm
    * Source: [](/modules/vm/windows-aad/)

## Required Inputs
The following input variables are required:

### location
Description: Must be specified, e.g. ```East US```. 
Defines the Azure region in which region bound resources are to be deployed.

### rgKV 
Description: Existing resource group of the Azure KeyVault

### kv
Description: Existing Azure KeyVault

### kvsecret
Description: Existing name of the secret for the P2S configuration

## Optional inputs
<b> Module hub-and-spoke</b>
- rg-vnet-hub 
- rg-spoke-01-vnet 
- rg-spoke-02-vnet 
- vnet-hub-name 
- vnet-spoke-01-name
- vnet-spoke-02-name

<b> Module aks </b>
- node_count

<b> Module vm </b>
- name
- resource_group_name 
- admin_username 


## Azure service principal 
Automated tools that deploy or use Azure services - such as Terraform - should always have restricted permissions. 

```azurecli
az ad sp create-for-rbac --name <service_principal_name> --role Contributor --scopes /subscriptions/<subscription_id>
```

Replace the <service_principal_name> with a custom name for your environment.

## Terraform CLI
### Overview
Terraform expects to be invoked from a working directory that contains configuration files written in the Terraform language. Terraform uses configuration content from this directory, and also uses the directory to store settings, cached plugins and modules, and sometimes state data.

A working directory must be initialized before Terraform can perform any operations in it (like provisioning infrastructure or modifying state).

### Working directory
A Terraform working directory typically contains:
- A Terraform configuration describing resources Terraform should manage. This configuration is expected to change over time.
- A hidden <b>.terraform</b> directory, which Terraform uses to manage cached provider plugins and modules, record which <b>workspace</b> is currently active, and record the last known backend configuration in case it needs to migrate state on the next run. This directory is automatically managed by Terraform, and is created during initialization.
- State data, if the configuration uses the default <b>local</b> backend. This is managed by Terraform in a <b>terraform.tfstate</b> file (if the directory only uses the default workspace) or a <b>terraform.tfstate.d</b> directory (if the directory uses multiple workspaces).

### Initialize Terraform
Run <b>terraform init</b> to initialize a working directory that contains a Terraform configuration. This command downloads the Azure provider required to manage the Azure resources. The <b>-upgrade</b> parameter upgrades the necassary provider plugins to the newest version that complies with the configurations version constraints.
```
terraform init -upgrade
```

### Create a Terraform execution plan
Run <b>terraform plan</b> to create an execution plan. 
```
terraform plan
```

### Apply a Terraform execution plan
Run <b>terraform apply</b> to apply the execution plan.
```
terraform apply
```

## Next steps...
:file_folder: Please switch to the [Module: Hub and spoke network](./modules/hub-and-spoke/README.md).</br>
:file_folder: Please switch to the [Module: Azure Kuberenetes Service](./modules/aks/README.md).</br>
:file_folder: Please switch to the [Module: Azure Virtual machine with AAD and IIS extension](./modules/vm/windows-aad/README.md).</br>