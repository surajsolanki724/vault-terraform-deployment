variable "vault_address" {
  description = "The URL of the Vault instance"
  type = string
}

variable "vault_username" {
  description = "The Vault token used for authentication"
  type = string
}

variable "vault_password" {
  description = "The Vault token used for authentication"
  type = string
}

variable "aws_region" {
  description = "The AWS region in which to create the parameter store value"
  type = string
}

variable "app_secret_path" {
  description = "The Secret path which to create in vault"
  type = string
}

variable "app_secret_policy_path" {
  description = "The Policy Secret path which to create in vault"
  type = string
}

variable "app_policy_name" {
   description = "The App policy name which to create in vault"
   type = string
}

variable "app_approle_name" {
  description = "The Application approle name which to create in vault"
  type = string
}

variable "token_parameter_name" {
  description = "The Token parameter name in which to create the parameter store"
  type = string
}

variable "app_parameter_name" {
  description = "The App parameter name in which to create the parameter store for s3 reference"
  type = string
}

variable "app_parameter_value" {
   description = "The App parameter value in which to create the parameter store for s3 reference"
   type = string
}