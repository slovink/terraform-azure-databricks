<!-- This file was automatically generated by the `geine`. Make all changes to `README.yaml` and run `make readme` to rebuild this file. -->

<p align="center"> <img src="https://user-images.githubusercontent.com/50652676/62349836-882fef80-b51e-11e9-99e3-7b974309c7e3.png" width="100" height="100"></p>


<h1 align="center">
    Terraform AZURE DATABRICKS
</h1>

<p align="center" style="font-size: 1.2rem;">
    Terraform module to create Azure databricks service resource on AZURE.
     </p>

<p align="center">

<a href="https://www.terraform.io">
  <img src="https://img.shields.io/badge/Terraform-v1.1.7-green" alt="Terraform">
</a>
<a href="LICENSE.md">
  <img src="https://img.shields.io/badge/License-APACHE-blue.svg" alt="Licence">
</a>


</p>
<p align="center">

<a href='https://facebook.com/sharer/sharer.php?u=https://github.com/slovink/terraform-azure-databricks'>
  <img title="Share on Facebook" src="https://user-images.githubusercontent.com/50652676/62817743-4f64cb80-bb59-11e9-90c7-b057252ded50.png" />
</a>
<a href='https://www.linkedin.com/shareArticle?mini=true&title=Terraform+AZURE+DATABRICKS&url=https://github.com/slovink/terraform-azure-databricks'>
  <img title="Share on LinkedIn" src="https://user-images.githubusercontent.com/50652676/62817742-4e339e80-bb59-11e9-87b9-a1f68cae1049.png" />
</a>
<a href='https://twitter.com/intent/tweet/?text=Terraform+AZURE+DATABRICKS&url=https://github.com/slovink/terraform-azure-databricks'>
  <img title="Share on Twitter" src="https://user-images.githubusercontent.com/50652676/62817740-4c69db00-bb59-11e9-8a79-3580fbbf6d5c.png" />
</a>

</p>
<hr>


We eat, drink, sleep and most importantly love **DevOps**. We are working towards strategies for standardizing architecture while ensuring security for the infrastructure. We are strong believer of the philosophy <b>Bigger problems are always solved by breaking them into smaller manageable problems</b>. Resonating with microservices architecture, it is considered best-practice to run database, cluster, storage in smaller <b>connected yet manageable pieces</b> within the infrastructure.

This module is basically combination of [Terraform open source](https://www.terraform.io/) and includes automatation tests and examples. It also helps to create and improve your infrastructure with minimalistic code instead of maintaining the whole infrastructure code yourself.

We have [*fifty plus terraform modules*][terraform_modules]. A few of them are comepleted and are available for open source usage while a few others are in progress.




## Prerequisites

This module has a few dependencies:






## Examples


**IMPORTANT:** Since the `master` branch used in `source` varies based on new modifications, we suggest that you use the release versions [here](https://github.com/slovink/terraform-azure-databricks/releases).


Here are some examples of how you can use this module in your inventory structure:
### azure databricks
```hcl
  # Basic
  module "databricks" {
source                                               = "../"
name                                                 = "app"
environment                                          = "test"
label_order                                          = ["name", "environment"]
enable                                               = true
resource_group_name                                  = module.resource_group.resource_group_name
location                                             = module.resource_group.resource_group_location
sku                                                  = "standard"
network_security_group_rules_required                = "NoAzureDatabricksRules"
public_network_access_enabled                        = false
managed_resource_group_name                          = "databricks-resource-group"
virtual_network_id                                   = module.vnet.vnet_id[0]
public_subnet_name                                   = module.subnet_pub.default_subnet_name[0]
private_subnet_name                                  = module.subnet_pvt.default_subnet_name[0]
public_subnet_network_security_group_association_id  = module.network_security_group_public.id
private_subnet_network_security_group_association_id = module.network_security_group_private.id
no_public_ip                                         = true
storage_account_name                                 = "databrickstestingcd"

cluster_enable          = true
autotermination_minutes = 20
# spark_version = "11.3.x-scala2.12" # Enter manual spark version or will choose latest spark version
# num_workers             = 0  # Required when enable_autoscale is false

enable_autoscale = true
min_workers      = 1
max_workers      = 2

cluster_profile = "multiNode"
}
  ```






## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| autotermination\_minutes | Set a minutes to auto terminate cluster if it's unhealthy. | `number` | n/a | yes |
| cluster\_enable | Set to false to prevent the databricks cluster from creating it's resources. | `bool` | `false` | no |
| cluster\_profile | The profile that Cluster will be contain. Possible values are 'singleNode' and 'multiNode' | `string` | `""` | no |
| enable | Set to false to prevent the module from creating any resources. | `bool` | `false` | no |
| enable\_autoscale | Set to false to not enable the Autoscale feature from the cluster. | `bool` | `false` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| label\_order | Label order, e.g. sequence of application name and environment `name`,`environment`,'attribute' [`webserver`,`qa`,`devops`,`public`,] . | `list(any)` | `[]` | no |
| location | The location/region where the virtual network is created. Changing this forces a new resource to be created. | `string` | `""` | no |
| managed\_resource\_group\_name | Managed Resource Group name to create Resource group by provided name. | `string` | `""` | no |
| managedby | Managed By e.g. slovink  | `string` | `""` | no |
| max\_workers | Set a Ammount of maximum workers that needs to be created among with Databricks Cluster. | `number` | n/a | yes |
| min\_workers | Set a Ammount of minimum workers that needs to be created among with Databricks Cluster. | `number` | n/a | yes |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| network\_security\_group\_rules\_required | Does the data plane (clusters) to control plane communication happen over private link endpoint only or publicly? Possible values AllRules, NoAzureDatabricksRules or NoAzureServiceRules. Required when public\_network\_access\_enabled is set to false. | `string` | `""` | no |
| no\_public\_ip | Select true to disble public IP. | `string` | `""` | no |
| num\_workers | Set a Ammount of workers that needs to be created among with Databricks Cluster. | `number` | `0` | no |
| private\_subnet\_name | Private Subnet Name to attach with databricks. | `string` | `""` | no |
| private\_subnet\_network\_security\_group\_association\_id | Private subnet Network security group association ID of the Virtual Network to attach with databricks. | `string` | `""` | no |
| public\_network\_access\_enabled | Set to false to disable public Network access to the databricks. | `bool` | n/a | yes |
| public\_subnet\_name | Public Subnet Name to attach with databricks. | `string` | `""` | no |
| public\_subnet\_network\_security\_group\_association\_id | Public subnet Network security group association ID of the Virtual Network to attach with databricks. | `string` | `""` | no |
| repository | Terraform current module repo | `string` | `""` | no |
| resource\_group\_name | The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created. | `string` | `""` | no |
| sku | The sku to use for the Databricks Workspace. Possible values are standard, premium, or trial. | `string` | `""` | no |
| spark\_version | Enter the Spark version to to create the Databricks's Cluster. | `string` | `null` | no |
| storage\_account\_name | Storage account name to attach with databricks. | `string` | `""` | no |
| virtual\_network\_id | Id of the Virtual Network to attach with databricks. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Specifies the resource id of the Workspace. |




## Testing
In this module testing is performed with [terratest](https://github.com/gruntwork-io/terratest) and it creates a small piece of infrastructure, matches the output like ARN, ID and Tags name etc and destroy infrastructure in your AWS account. This testing is written in GO, so you need a [GO environment](https://golang.org/doc/install) in your system.

You need to run the following command in the testing folder:
```hcl
  go test -run Test
```



## Feedback
If you come accross a bug or have any feedback, please log it in our [issue tracker](https://github.com/slovink/terraform-azure-databricks/issues), or feel free to drop us an email at [contact@slovink.com](https:contact@slovink.com).

If you have found it worth your time, go ahead and give us a ★ on [our GitHub](https://github.com/slovink/terraform-azure-databricks)!

## About us

At [slovink][website], we offer expert guidance, implementation support and services to help organisations accelerate their journey to the cloud. Our services include docker and container orchestration, cloud migration and adoption, infrastructure automation, application modernisation and remediation, and performance engineering.

<p align="center">We are <b> The Cloud Experts!</b></p>
<hr />
<p align="center">We ❤️  <a href="https://github.com/slovink">Open Source</a> and you can check out <a href="https://github.com/slovink">our other modules</a> to get help with your new Cloud ideas.</p>

## follow us
[[website](https://slovink.com)]

[[github](https://slovink.com)]

[[twitter](https://twitter.com/slovink127795)]



<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.6.6 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.87.0 |
| <a name="requirement_databricks"></a> [databricks](#requirement\_databricks) | 1.36.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.87.0 |
| <a name="provider_databricks"></a> [databricks](#provider\_databricks) | 1.36.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_labels"></a> [labels](#module\_labels) | git@github.com:slovink/terraform-azure-labels.git | 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_databricks_workspace.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/databricks_workspace) | resource |
| [databricks_cluster.cluster](https://registry.terraform.io/providers/databricks/databricks/1.36.3/docs/resources/cluster) | resource |
| [databricks_node_type.smallest](https://registry.terraform.io/providers/databricks/databricks/1.36.3/docs/data-sources/node_type) | data source |
| [databricks_spark_version.latest_lts](https://registry.terraform.io/providers/databricks/databricks/1.36.3/docs/data-sources/spark_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autotermination_minutes"></a> [autotermination\_minutes](#input\_autotermination\_minutes) | Set a minutes to auto terminate cluster if it's unhealthy. | `number` | n/a | yes |
| <a name="input_cluster_enable"></a> [cluster\_enable](#input\_cluster\_enable) | Set to false to prevent the databricks cluster from creating it's resources. | `bool` | `false` | no |
| <a name="input_cluster_profile"></a> [cluster\_profile](#input\_cluster\_profile) | The profile that Cluster will be contain. Possible values are 'singleNode' and 'multiNode' | `string` | `""` | no |
| <a name="input_enable"></a> [enable](#input\_enable) | Set to false to prevent the module from creating any resources. | `bool` | `false` | no |
| <a name="input_enable_autoscale"></a> [enable\_autoscale](#input\_enable\_autoscale) | Set to false to not enable the Autoscale feature from the cluster. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | Label order, e.g. sequence of application name and environment `name`,`environment`,'attribute' [`webserver`,`qa`,`devops`,`public`,] . | `list(any)` | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | The location/region where the virtual network is created. Changing this forces a new resource to be created. | `string` | `""` | no |
| <a name="input_managed_resource_group_name"></a> [managed\_resource\_group\_name](#input\_managed\_resource\_group\_name) | Managed Resource Group name to create Resource group by provided name. | `string` | `""` | no |
| <a name="input_managedby"></a> [managedby](#input\_managedby) | Managed By e.g. slovink, | `string` | `"contact@slovink.com"` | no |
| <a name="input_max_workers"></a> [max\_workers](#input\_max\_workers) | Set a Ammount of maximum workers that needs to be created among with Databricks Cluster. | `number` | n/a | yes |
| <a name="input_min_workers"></a> [min\_workers](#input\_min\_workers) | Set a Ammount of minimum workers that needs to be created among with Databricks Cluster. | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| <a name="input_network_security_group_rules_required"></a> [network\_security\_group\_rules\_required](#input\_network\_security\_group\_rules\_required) | Does the data plane (clusters) to control plane communication happen over private link endpoint only or publicly? Possible values AllRules, NoAzureDatabricksRules or NoAzureServiceRules. Required when public\_network\_access\_enabled is set to false. | `string` | `""` | no |
| <a name="input_no_public_ip"></a> [no\_public\_ip](#input\_no\_public\_ip) | Select true to disble public IP. | `string` | `""` | no |
| <a name="input_num_workers"></a> [num\_workers](#input\_num\_workers) | Set a Ammount of workers that needs to be created among with Databricks Cluster. | `number` | `0` | no |
| <a name="input_private_subnet_name"></a> [private\_subnet\_name](#input\_private\_subnet\_name) | Private Subnet Name to attach with databricks. | `string` | `""` | no |
| <a name="input_private_subnet_network_security_group_association_id"></a> [private\_subnet\_network\_security\_group\_association\_id](#input\_private\_subnet\_network\_security\_group\_association\_id) | Private subnet Network security group association ID of the Virtual Network to attach with databricks. | `string` | `""` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Set to false to disable public Network access to the databricks. | `bool` | n/a | yes |
| <a name="input_public_subnet_name"></a> [public\_subnet\_name](#input\_public\_subnet\_name) | Public Subnet Name to attach with databricks. | `string` | `""` | no |
| <a name="input_public_subnet_network_security_group_association_id"></a> [public\_subnet\_network\_security\_group\_association\_id](#input\_public\_subnet\_network\_security\_group\_association\_id) | Public subnet Network security group association ID of the Virtual Network to attach with databricks. | `string` | `""` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Terraform current module repo | `string` | `""` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created. | `string` | `""` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The sku to use for the Databricks Workspace. Possible values are standard, premium, or trial. | `string` | `""` | no |
| <a name="input_spark_version"></a> [spark\_version](#input\_spark\_version) | Enter the Spark version to to create the Databricks's Cluster. | `string` | `null` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | Storage account name to attach with databricks. | `string` | `"fabricated"` | no |
| <a name="input_virtual_network_id"></a> [virtual\_network\_id](#input\_virtual\_network\_id) | Id of the Virtual Network to attach with databricks. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Specifies the resource id of the Workspace. |
<!-- END_TF_DOCS -->