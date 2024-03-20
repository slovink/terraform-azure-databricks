terraform {
  required_version = ">=1.7.4"
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.87.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "1.36.3"
    }
  }
}

