data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

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
    data.azurerm_subscription.current.id
  ]
}