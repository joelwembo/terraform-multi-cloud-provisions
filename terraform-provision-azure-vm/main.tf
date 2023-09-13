# Configure the Azure Provider
provider "azurerm" {
  skip_provider_registration = "true"
  subscription_id = ""
#   subscription_id = ""
  client_id       = ""
  client_secret   = ""
  tenant_id       = "6b37dcac-xxxxxx"
  features {
    
  }
}

variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
}

variable "location" {
  description = "eastus"
}

resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-resources"
  location = "eastus"
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/22"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                            = "${var.prefix}-vm"
  resource_group_name             = azurerm_resource_group.main.name
  location                        = "eastus"
  size                            = "Standard_D2s_v3"
  admin_username                  = "ubuntu"
  admin_password                  = "abcd@12345678"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}
