data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "example" {
  name     = local.storage_account_name
  location = "West Europe"
}

resource "azurerm_virtual_network" "example" {
  name                = "virtualNetwork"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = [local.vnet_address_space]
}

#tfsec:ignore:azure-keyvault-specify-network-acl
resource "azurerm_key_vault" "key_vault" {
  name                = "terramdemosamplekeyvault"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  purge_protection_enabled   = true
  soft_delete_retention_days = 7

  sku_name                  = "standard"
  enable_rbac_authorization = true

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }
}
