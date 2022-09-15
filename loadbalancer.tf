resource "azurerm_lb" "demolb" {
    name = "demolb"
    sku = "Standard"
    sku_tier = "Regional"
    location = azurerm_resource_group.myterraformgroup.location
    resource_group_name = azurerm_resource_group.myterraformgroup.name

    frontend_ip_configuration {
        name = "ServerLB"
        subnet_id = azurerm_subnet.privatesubnet.id
        private_ip_address_allocation = "Static"
        private_ip_address = "10.1.1.4"
    }
}

resource "azurerm_lb_backend_address_pool" "ServerLB" {
  loadbalancer_id = azurerm_lb.demolb.id
  name = "WebServers"
}

resource "azurerm_lb_backend_address_pool_address" "Webserver1" {
  name = "server1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.ServerLB.id
  virtual_network_id = azurerm_virtual_network.fgtvnetwork.id
  ip_address = azurerm_network_interface.ServerNIC1.private_ip_address
}

resource "azurerm_lb_backend_address_pool_address" "Webserver2" {
  name = "server2"
  backend_address_pool_id = azurerm_lb_backend_address_pool.ServerLB.id
  virtual_network_id = azurerm_virtual_network.fgtvnetwork.id
  ip_address = azurerm_network_interface.Server2NIC1.private_ip_address
}

resource "azurerm_lb_probe" "Healthcheck1" {
  name = "webserver-health"
  loadbalancer_id = azurerm_lb.demolb.id
  port = "80"
  protocol = "Tcp"
}

resource "azurerm_lb_rule" "ServerRules" {
  name = "ServerRules"
  loadbalancer_id = azurerm_lb.demolb.id
  frontend_ip_configuration_name = azurerm_lb.demolb.frontend_ip_configuration[0].name
  frontend_port = "80"
  protocol = "Tcp"
  probe_id = azurerm_lb_probe.Healthcheck1.id
  backend_port = "80"
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.ServerLB.id]
}