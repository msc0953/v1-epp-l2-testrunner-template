variable "azure_personal_access_token" {
    description = "The Azure DevOps organization personal access token"
    type        = string
}
variable "org_service_url" {
    description = "The Azure DevOps organization url"
    type        = string
}
variable "project_name" {
    description = "The Project Name of L2 Testing Environment"
    type        = string
    default     = "v1-epp-l2-testing-poc"
}
variable "test_runner_pool_name" {
    description = "The pool are used for test runner instances"
    type        = string
    default     = "v1-epp-testrunner-agents"
}
variable "container_registry_name" {
    description = "The Name of Azure Container Registry"
    type        = string  
    default     = "testrunnercontainerregistry"  
}
variable "container_group_name" {
    description = "The name of Group Name"
    type        = string  
    default     = "v1-epp-testrunner-container-group"
}
variable "resource_group_name" {
    description = "The L2 Testing infrasture resource group"
    type        = string
    default     = "v1-epp-poc-l2-rg"
}
variable "location" {
    description = "The Location of L2 Infrastructure"
    type        = string
    default     = "westus2"
}