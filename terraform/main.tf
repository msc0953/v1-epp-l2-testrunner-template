terraform {
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = "0.1.2"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azuredevops" {
  org_service_url       = var.org_service_url
  personal_access_token = var.azure_personal_access_token
}

data "azurerm_subscription" "current" {
}

data "azurerm_resource_group" "vnet-rg" {
  name     = var.resource_group_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-aci-devops"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "aci-subnet" {
  name                 = "aci-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  delegation {
    name = "acidelegation"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
  }
}

module "aci-devops-agent" {
  source                  = "Azure/aci-devops-agent/azurerm"
  location                = var.location
  resource_group_name     = var.resource_group_name
  create_resource_group   = false

  enable_vnet_integration = false
  vnet_resource_group_name = var.resource_group_name
  vnet_name                = azurerm_virtual_network.vnet.name
  subnet_name              = azurerm_subnet.aci-subnet.name

  linux_agents_configuration = {
    agent_name_prefix = "v1-epp-l2-poc-agent"
    agent_pool_name   = var.test_runner_pool_name
    count             = 0
    docker_image      = "testrunnercontainerregistry.azurecr.io/pipelinetestrunnerdocker"
    docker_tag        = "latest"
    cpu               = 1
    memory            = 2
  }
  azure_devops_org_name              = var.org_service_url
  azure_devops_personal_access_token = var.azure_personal_access_token
  
  image_registry_credential = {
    username = "testrunnercontainerregistry"
    password = "nkWa75=Qg6bhT7W0DezmJzi9GydVexfO"
    server   = "testrunnercontainerregistry.azurecr.io"
  }
}
