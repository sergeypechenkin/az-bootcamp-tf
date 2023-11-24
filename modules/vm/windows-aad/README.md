# Module: Azure Virtual machine with AAD and IIS extension
Organizations can improve the security of Windows virtual machines (VMs) in Azure by integrating with Microsoft Entra authentication.


## Test IIS (web site)
You can check that the IIS has been installed correctly by retrieving the private IP address with the following command and then entering it in a web browser. 
```azurecli-interactive
az vm list-ip-addresses -g rg-VM -n vm01
```
<b>Note:</b> If you have changed the variables from [main.tf](/main.tf), you must also adapt them to the command accordingly

The default IIS website should now be displayed.

## Log in to the VM by using Azure AD
All access should be via AAD authentication. The local admin account are intended for break glass scenarios.

You can sign in over RDP using one of two methods:
1. Passwordless using any of the supported AAD credentials
2. Password/limited passwordless using Windows Hello for Business deployed using certificate trust model


Details installation instructions and troubleshooting can be found in the [Documentation](https://learn.microsoft.com/en-us/entra/identity/devices/howto-vm-sign-in-azure-ad-windows).


