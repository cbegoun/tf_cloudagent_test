data "azurerm_role_definition" "contributor" {
  name = "Contributor"
}

resource "azurerm_role_assignment" "mi_tf_customrole" {
  scope              = data.azurerm_subscription.current.id
  role_definition_id = azurerm_role_definition.TF_CustomRole.id
  principal_id       = azurerm_container_group.tf_agent_cg.identity[0].principal_id
}

resource "azurerm_role_assignment" "mi_contributor" {
  scope              = data.azurerm_subscription.current.id
  role_definition_id = "${data.azurerm_subscription.current.id}${data.azurerm_role_definition.contributor.id}"
  principal_id       = azurerm_container_group.tf_agent_cg.identity[0].principal_id
}