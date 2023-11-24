# Module: Azure Kubernetes Service (AKS)
Azure Kubernetes Service (AKS) is a managed Kubernetes service that lets you quickly deploy and manage clusters.


<b>`NOTE:`</b> This sample deployment is just for demo purposes and doesn't represent all the best practices for Kubernetes cluster/applications.

## Requirements
If necessary, please check whether the following tools are already installed.

- Azure CLI
    - Please refer to the [install guide](https://docs.microsoft.com/cli/azure/install-azure-cli) for detailed install instructions.

- Terraform
    - [Download](https://developer.hashicorp.com/terraform/downloads?product_intent=terraform)
    - Please refer to the [install cli](https://developer.hashicorp.com/terraform/tutorials/azure-get-started/install-cli) for detailed install instruction.

- Kubernetes CLI
    - [Download kubectl](https://kubernetes.io/releases/download/)



### Verify the results
Get the resource group of the AKS cluster.
```azurecli
az aks list \
  --resource-group $resource_group_name \
  --query "[].{\"k8s cluster name\":name}" \
  --output table
```

Get the Kubernetes configuration from the Terraform state and store it in a file that <b>kubectl</b> can read.
```azurecli
echo "$(terraform output kube_config)" > ./azurek8s
```

Verify the previous command didn't add an ASCII <b>EOT</b> character.
```azurecli
cat ./azurek8s
```

<b>`NOTE:`</b> If you see ```<< EOT``` at the beginning and ```EOT``` at the end, remove these characters from the file. Otherwise, you may receive the following error message: ```error: error loading config file "./azurek8s": yaml: line 2: mapping values are not allowed in this context```

Verify the health of the cluster
```azurecli
kubectl get nodes
```


### Deploy the demo application
```azurecli
kubectl apply -f .\scripts\aks\aks-store.yaml
```
Please make sure that you are in the correct path ```-f <path>``` before running the command. Otherwise the path must be adjusted.

### Test the demo application
Check for a public IP address for the store-front application.
```azurecli
kubectl get service store-front --watch
```

If the status of the <b>EXTERNAL IP</b> address changes from <b>pending</b> to a current public IP address, you can end the ```kubectl``` watch process with ```CTRL-C```

Finally, open a web browser to the external IP address of your service. You should now be able to see an application.