# terraform {
#   backend "azurerm" {
#     resource_group_name   = ""
#     storage_account_name  = ""
#     container_name        = ""
#     key                   = ""
#     access_key            = ""
#   }
# }

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.81.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = "true"
}