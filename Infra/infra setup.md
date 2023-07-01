# Setting up Infrastructure for Mediawiki on Azure
```One time steps performed```

- Created Key vault mediawiki-kv in a resource group(budget-rg)

- Added role assignment on the azure portal for my user to access secrets from the key vault

- Added public key generated locally to a secret on the keyvault to access vm via ssh authentication    
```
az keyvault secret set --name id_rsa --vault-name mediawiki-kv --resource-group budget-rg --file ~/.ssh/id_rsa
```
- Added ssh access to target vm with host vm IP after provisioning of virtual machines as public IP address is not known before ```terraform apply```

``` Infrastructure Details```

- The scripts contain 3 main modules.
    - Core: Resource group
    - Networking: Virtual Network and Subnets
    - Virtual Machine: Virtual Machine and it's necessary components

- Azurerm is the provider used

- SSH key authentication is used to login to the VMs, hence, no secrets/passwords are kept in any of the scripts.

- Network Security Group is created once with rules: 80(HTTP) and 22(SSH) accessible only with host ip address as source; 8080(Jenkins and Github Webhook) open to the internet

```Infrastructure provisioning```

- Use az login authentication for terraform

- To setup infra, clone the repository https://github.com/shivaswaroop40/thoughtworks-assignment.git

- Go to the infra directory

- Run the below commandss

```
terraform init #initialise all terraform modules

terraform validate #validate the configuration syntax

terraform plan #create a plan of the configuration

terraform apply #apply the configuration
```

```Documented Errors```


```
Error: Incompatible provider version 

Provider registry.terraform.io/hashicorp/template v2.2.0 does not have a package available for your current platform, darwin_arm64.
 
Provider releases are separate from Terraform CLI releases, so not all providers are available for all platforms. Other versions of this provider may have different platforms supported.
```


Here are the simple steps to resolve this issue:

1. Install “m1-terraform-provider-helper” with the help of the below command:

    ```brew install kreuzwerker/taps/m1-terraform-provider-helper```

2. Activate the plugin or helper utility.

    ```m1-terraform-provider-helper activate```

3. Install and compile the “hashicorp/template v2.2.0”.

    ```m1-terraform-provider-helper install hashicorp/template -v v2.2.0```

### After performing the above steps, encountered error no references found while installing the template provider, hence removed template file resource from the scripts.