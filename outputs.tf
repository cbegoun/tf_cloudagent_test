output "rg_name" {
  value = azurerm_resource_group.tf_agent_rg.rg_name
}

output "rg_id" {
  value = azurerm_resource_group.tf_agent_rg.rg_id
}

output "container_group_iden" {
  value = azurerm_container_group.tf_agent_cg.identity
}