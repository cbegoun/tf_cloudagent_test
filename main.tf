resource "azurerm_resource_group" "tfc_cloudagent_rg" {
  name     = "${var.prefix}-resources"
  location = var.location
}

resource "azurerm_virtual_network" "tfc_cloudagent_vn" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/22"]
  location            = azurerm_resource_group.tfc_cloudagent_rg.location
  resource_group_name = azurerm_resource_group.tfc_cloudagent_rg.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.tfc_cloudagent_rg.name
  virtual_network_name = azurerm_virtual_network.tfc_cloudagent_vn.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "tfc_cloudagent_nic" {
  name                = "${var.prefix}-nic"
  resource_group_name = azurerm_resource_group.tfc_cloudagent_rg.name
  location            = azurerm_resource_group.tfc_cloudagent_rg.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "tfc_cloudagent_vm" {
  name                            = "${var.prefix}-vm"
  resource_group_name             = azurerm_resource_group.tfc_cloudagent_rg.name
  location                        = azurerm_resource_group.tfc_cloudagent_rg.location
  size                            = "Standard_B1s"
  admin_username                  = var.ADMIN_USERNAME
  admin_password                  = var.ADMIN_PASSWORD
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.tfc_cloudagent_nic.id,
  ]

  identity {
    type = "SystemAssigned"
  }

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

data "azurerm_role_definition" "contributor" {
  name = "Contributor"
}

data "azurerem_role_definition" "TF_CustomRole" {
  name = "TF_CustomRole"
}

data "azurerm_subscription" "current" {}
resource "azurerm_role_assignment" "mi_contributor" {
  scope              = data.azurerm_subscription.current.id
  role_definition_id = "${data.azurerm_subscription.current.id}${data.azurerm_role_definition.contributor.id}"
  principal_id       = azurerm_linux_virtual_machine.tfc_cloudagent_vm.identity[0].principal_id
}

resource "azurerm_role_assignment" "mi_tf_customrole" {
  scope              = data.azurerm_subscription.current.id
  role_definition_id = "${data.azurerm_subscription.current.id}${data.azurerm_role_definition.TF_CustomRole.id}"
  principal_id       = azurerm_linux_virtual_machine.tfc_cloudagent_vm.identity[0].principal_id
}