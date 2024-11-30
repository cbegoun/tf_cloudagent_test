output "public_ip" {
  value = azurerm_linux_virtual_machine.tfc_cloudagent_vm.public_ip_address
}