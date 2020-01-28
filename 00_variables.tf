variable "prefix" {
  description = "The prefix for the resources created in the specified Azure Resource Group"
}

variable "location" {
  #default     = "eastus"
  description = "The location for the deployment"
}

variable "env" {
  description = "different environments: dev, sit, uat, prod"
}

variable "ARM_CLIENT_ID" {
  description = "The Client ID (appId) for the Service Principal used for the deployment"
}

variable "ARM_CLIENT_SECRET" {
  description = "The Client Secret (password) for the Service Principal used for the deployment"
}

variable "tenant" {
  description = "Azure tenant to be used"
}

variable "subscription" {
  description = "Azure subscription to be used"
}

variable "password" {
  description = "OS Password"
}
##########################----------##########################

variable "ARM_VNETADDRESSSPACE" {
  type        = "string"
  description = "CIDR Range for Bastion vNet"
  default     = "200.200.200.0/24"
}

variable "jumpsub" {
  type        = "string"
  description = "bastion subnet"
  default     = "200.200.200.32/28"
}

variable "jump_server_count" {
  type    = number
  default = 2
}

variable "default_tags" {
  default = {
    ENV = "dev"
    APP = "ado"
    BU  = "marketing"
    CTC = "eng@support.local"
    Tag5 = "tst5"
    Tag6 = "tst6"
    Tag6 = "tst7"
    Tag6 = "tst8"
    Tag6 = "tst9"
    Tag6 = "tst10"
    Tag6 = "tst11"
    Tag6 = "tst12"
    Tag6 = "tst13"
    Tag6 = "tst14"
    Tag6 = "tst15"
    Tag6 = "tst16"
  }
}

# variable "long_key" {
#   type = "string"
#   default = <<EOF
# This is a long key.
# Running over several lines.
# EOF
# }