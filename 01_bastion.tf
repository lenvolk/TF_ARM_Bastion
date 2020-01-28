
###################--------------###################
resource "azurerm_resource_group" "bastion-rg" {
  name     = join("-", [var.prefix, var.location, "rg"])
  location = var.location
  tags     = var.default_tags
  }

resource "azurerm_virtual_network" "sharedservicesvnet" {
  name                = join("-", [var.prefix, var.location, "vnet"])
  location            = var.location
  resource_group_name = azurerm_resource_group.bastion-rg.name
  address_space       = [var.ARM_VNETADDRESSSPACE]
  tags                = var.default_tags
}

# data "azurerm_resource_group" "basrg" {
#   name = "${var.prefix}-${var.location}-rg"
# }

module "Az-Bastion" {
  source              = "git::https://github.com/lenvolk/terraform.git//module/Az-Bastion?ref=develop"
  location            = var.location
  resourceGroupName   = azurerm_resource_group.bastion-rg.name
  bastionHostName     = join("-", [var.prefix, "bastion"])
  existingVNETName    = azurerm_virtual_network.sharedservicesvnet.name
  publicIpAddressName = join("-", ["pip-bastion", var.location])
  subnetAddressPrefix = cidrsubnet(var.ARM_VNETADDRESSSPACE, 3, 0)
  tags                = var.default_tags
}


#Module's output
output "bastion_id" {
  value = module.Az-Bastion.bastion_id
}