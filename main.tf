resource "azurerm_resource_group" "tf_agent_rg" {
  name     = "rg-${var.sub_prefix}-${var.app_prefix}-${var.app_env}-${var.location}"
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "tf_agent_vn" {
  name                = "vn-${var.sub_prefix}-${var.app_prefix}-${var.app_env}-${var.location}"
  address_space       = ["10.0.0.0/22"]
  location            = azurerm_resource_group.tf_agent_rg.location
  resource_group_name = azurerm_resource_group.tf_agent_rg.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.tf_agent_rg.name
  virtual_network_name = azurerm_virtual_network.tf_agent_vn.name
  address_prefixes     = ["10.0.2.0/24"]
}