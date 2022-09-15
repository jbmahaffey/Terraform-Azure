output "ResourceGroup" {
  value = azurerm_resource_group.myterraformgroup.name
}

output "FGTPublicIP" {
  value = azurerm_public_ip.FGTPublicIp.ip_address
}

output "UbuntuSSH" {
    value = tls_private_key.azure_key.id
}

output "FGTInternalPrivateIP" {
  value = azurerm_network_interface.fgtport1.private_ip_address
}

output "Username" {
  value = var.adminusername
}

output "Password" {
  value = var.adminpassword
}

output "tls_private_key" {
  value     = tls_private_key.azure_key.private_key_pem
  sensitive = true
}