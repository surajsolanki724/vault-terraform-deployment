## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.63.0 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | 3.14.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_parameter.app_env_parameter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.app_token_parameter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [vault_approle_auth_backend_login.login](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/approle_auth_backend_login) | resource |
| [vault_approle_auth_backend_role.app_approle](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/approle_auth_backend_role) | resource |
| [vault_approle_auth_backend_role_secret_id.app_secret_id](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/approle_auth_backend_role_secret_id) | resource |
| [vault_generic_secret.app_secret](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/generic_secret) | resource |
| [vault_policy.app_policy](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_approle_name"></a> [app\_approle\_name](#input\_app\_approle\_name) | The Application approle name which to create in vault | `any` | n/a | yes |
| <a name="input_app_parameter_name"></a> [app\_parameter\_name](#input\_app\_parameter\_name) | The App parameter name in which to create the parameter store for s3 reference | `any` | n/a | yes |
| <a name="input_app_parameter_value"></a> [app\_parameter\_value](#input\_app\_parameter\_value) | The App parameter value in which to create the parameter store for s3 reference | `any` | n/a | yes |
| <a name="input_app_policy_name"></a> [app\_policy\_name](#input\_app\_policy\_name) | The App policy name which to create in vault | `any` | n/a | yes |
| <a name="input_app_secret_path"></a> [app\_secret\_path](#input\_app\_secret\_path) | The Secret path which to create in vault | `any` | n/a | yes |
| <a name="input_app_secret_policy_path"></a> [app\_secret\_policy\_path](#input\_app\_secret\_policy\_path) | The Policy Secret path which to create in vault | `any` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region in which to create the parameter store value | `any` | n/a | yes |
| <a name="input_token_parameter_name"></a> [token\_parameter\_name](#input\_token\_parameter\_name) | The Token parameter name in which to create the parameter store | `any` | n/a | yes |
| <a name="input_vault_address"></a> [vault\_address](#input\_vault\_address) | The URL of the Vault instance | `any` | n/a | yes |
| <a name="input_vault_password"></a> [vault\_password](#input\_vault\_password) | The Vault token used for authentication | `any` | n/a | yes |
| <a name="input_vault_username"></a> [vault\_username](#input\_vault\_username) | The Vault token used for authentication | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_approle_token"></a> [approle\_token](#output\_approle\_token) | n/a |
