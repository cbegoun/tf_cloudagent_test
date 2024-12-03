data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

data "azurerm_management_group" "tenant" {
    name = "b48fc275-a22d-47ec-b85f-0af6bbf7c290"
}

resource "azurerm_role_definition" "TF_CustomRole" {
  name  = "TF_CustomRole"
  scope = data.azurerm_subscription.current.id

  permissions {
    actions = [
      "Microsoft.Network/virtualNetworks/subnets/join/action"
    ]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_management_group.tenant.id
  ]
}