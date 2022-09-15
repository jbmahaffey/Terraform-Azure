// Resource Group

resource "azurerm_resource_group" "myterraformgroup" {
  name     = "Demo-Environment"
  location = var.location

  tags = {
    environment = "Terraform Demo"
  }
}

# Create (and display) an SSH key
resource "tls_private_key" "azure_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}