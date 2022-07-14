data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "example" {
  name     = "demorg01"
  location = "West Europe"
}

resource "azurerm_virtual_network" "example" {
  name                = "demo-vnet01"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "vnet01-subnet01"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage"]
  enforce_private_link_service_network_policies  = true
  enforce_private_link_endpoint_network_policies  = true
}

resource "azurerm_storage_account" "example" {
  name                = "demostgaccoo1"
  resource_group_name = azurerm_resource_group.example.name

  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version = "TLS1_2"

  network_rules {
    default_action             = "Deny"
    ip_rules                   = ["100.0.0.1"]
    virtual_network_subnet_ids = [azurerm_subnet.example.id]
  }

  tags = {
    environment = "staging"
  }
}
