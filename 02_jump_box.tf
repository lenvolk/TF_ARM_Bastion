resource "azurerm_resource_group" "jump_rg" {
  name     = join("-", [var.prefix, var.location, "jumpbox","rg"])
  location = var.location
  tags     = var.default_tags
  }

resource "azurerm_network_security_group" "jump_server_nsg" {
  name                = join("-", [var.prefix, var.location, "jumpbox","nsg"])
  location            = var.location
  resource_group_name = azurerm_resource_group.jump_rg.name
  tags                = var.default_tags
}

resource "azurerm_subnet" "jump_server_subnet" {
  name                      = join("-", [var.prefix, var.location, "jumpbox","subnet"])
  resource_group_name       = azurerm_resource_group.bastion-rg.name
  virtual_network_name      = azurerm_virtual_network.sharedservicesvnet.name
  address_prefix            = var.jumpsub
  network_security_group_id = azurerm_network_security_group.jump_server_nsg.id
}

#####======VMSS==========######
## https://docs.microsoft.com/en-us/azure/terraform/terraform-create-vm-scaleset-network-disks-using-packer-hcl

resource "azurerm_virtual_machine_scale_set" "jump_server" {
  name                         = "vmssjump" #limit is 9 char
  location                     = var.location
  resource_group_name          = azurerm_resource_group.jump_rg.name
  upgrade_policy_mode          = "manual"

  sku {
    name     = "Standard_B1s"
    tier     = "Standard"
    capacity = var.jump_server_count
  }

  storage_profile_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  storage_profile_os_disk {
    name              = ""
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  
  os_profile {
    computer_name_prefix = "vmlab"
    admin_username       = "ladmin"
    admin_password       = var.password
  }

  os_profile_windows_config {
    provision_vm_agent = true
  }

  network_profile {
    name    = "vmssjumpnetprof"
    primary = true

    ip_configuration {
      name                                   = "vmssjumpip"
      primary                                = true
      subnet_id                              = "${azurerm_subnet.jump_server_subnet.id}"
      #load_balancer_backend_address_pool_ids = ["${azurerm_lb_backend_address_pool.web_server_lb_backend_pool.id}"]
    }
  }
}