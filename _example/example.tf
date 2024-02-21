provider "azurerm" {
  features {}
}

provider "databricks" {
  azure_workspace_resource_id = "module.databricks.id"
}

terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
    }
  }
}

module "resource_group" {
  source      = "git@github.com:slovink/terraform-azure-resource-group.git?ref=1.0.0"
  name        = "app"
  environment = "test"
  label_order = ["environment", "name", ]
  location    = "North Europe"
}

module "vnet" {
  source = "git@github.com:slovink/terraform-azure-vnet.git?ref=1.0.0"

  name                = "app"
  environment         = "test"
  label_order         = ["name", "environment"]
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  address_space       = "10.0.0.0/16"
  enable_ddos_pp      = false

  depends_on = [
    module.resource_group
  ]
}

module "subnet_pub" {
  source               = "git@github.com:slovink/terraform-azure-subnet.git?ref=1.0.0"
  name                 = "app"
  environment          = "test"
  label_order          = ["name", "environment"]
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  virtual_network_name = module.vnet.name

  #subnet
  subnet_names    = ["pub-subnet"]
  subnet_prefixes = ["10.0.1.0/24"]

  delegation = {
    service_delegation = [
      {
        name    = "Microsoft.Databricks/workspaces"
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
      }
    ]
  }

  depends_on = [
    module.resource_group
  ]
}

module "subnet_pvt" {
  source = "git@github.com:slovink/terraform-azure-subnet.git?ref=1.0.0"

  name                 = "app"
  environment          = "test"
  label_order          = ["name", "environment"]
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  virtual_network_name = module.vnet.name

  #subnet
  subnet_names    = ["pvt-subnet"]
  subnet_prefixes = ["10.0.2.0/24"]

  delegation = {
    service_delegation = [
      {
        name    = "Microsoft.Databricks/workspaces"
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
      }
    ]
  }

  depends_on = [
    module.resource_group
  ]
}

module "network_security_group_public" {
  depends_on              = [module.subnet_pub]
  source                  = "git@github.com:slovink/terraform-azure-network-security-group.git?ref=1.0.0"
  resource_group_location = module.resource_group.resource_group_location
  label_order             = ["name", "environment"]
  name                    = "app-pub"
  environment             = "test"
  subnet_ids              = [module.subnet_pub.default_subnet_id]
  resource_group_name     = module.resource_group.resource_group_name
}

module "network_security_group_private" {
  depends_on              = [module.subnet_pvt]
  source                  = "git@github.com:slovink/terraform-azure-network-security-group.git?ref=1.0.0"
  resource_group_location = module.resource_group.resource_group_location
  label_order             = ["name", "environment"]
  name                    = "app-pvt"
  environment             = "test"
  subnet_ids              = [module.subnet_pvt.default_subnet_id]
  resource_group_name     = module.resource_group.resource_group_name
}

module "databricks" {
  source                                               = "../"
  name                                                 = "databricks"
  environment                                          = "test"
  label_order                                          = ["name", "environment"]
  enable                                               = true
  resource_group_name                                  = module.resource_group.resource_group_name
  location                                             = module.resource_group.resource_group_location
  sku                                                  = "trial"
  network_security_group_rules_required                = "AllRules"
  public_network_access_enabled                        = true
  managed_resource_group_name                          = "databricks-resource-group"
  virtual_network_id                                   = module.vnet.id
  public_subnet_name                                   = module.subnet_pub.default_subnet_name
  private_subnet_name                                  = module.subnet_pvt.default_subnet_name
  public_subnet_network_security_group_association_id  = module.network_security_group_public.id
  private_subnet_network_security_group_association_id = module.network_security_group_private.id
  no_public_ip                                         = false
  storage_account_name                                 = "fabricated"

  cluster_enable          = true
  autotermination_minutes = 20
  # spark_version = "11.3.x-scala2.12" # Enter manual spark version or will choose latest spark version
  # num_workers             = 0  # Required when enable_autoscale is false

  enable_autoscale = true
  min_workers      = 1
  max_workers      = 2

  cluster_profile = "multiNode"

  depends_on = [
    module.network_security_group_private,
    module.network_security_group_public,
  ]
}
