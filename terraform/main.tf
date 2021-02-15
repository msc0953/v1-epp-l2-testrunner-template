module "aci-devops-agent" {
  source                  = "Azure/aci-devops-agent/azurerm"
  resource_group_name     = "rg-linux-devops-agents"
  location                = "westeurope"
  enable_vnet_integration = false
  create_resource_group   = true

  linux_agents_configuration = {
    agent_name_prefix = "linux-agent"
    agent_pool_name   = "DEVOPS_POOL_NAME"
    count             = 2,
    docker_image      = "testrunnercontainerregistry.azurecr.io/pipelinetestrunnerdocker:latest"
    docker_tag        = "latest"
    cpu               = 1
    memory            = 4
  }
  azure_devops_org_name              = "DEVOPS_ORG_NAME"
  azure_devops_personal_access_token = "DEVOPS_PERSONAL_ACCESS_TOKEN"
}