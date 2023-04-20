# Create an Secret

resource "vault_generic_secret" "app_secret" {
  path = var.app_secret_path
  data_json = <<EOT
{
}
EOT
}

# Create an Policy

resource "vault_policy" "app_policy" {
  name = var.app_policy_name

  policy = <<EOT
path "${var.app_secret_policy_path}"{
  capabilities = ["read","list"]
}
EOT
}

# Create an AppRole

resource "vault_approle_auth_backend_role" "app_approle" {
  backend        = "approle"
  role_name      = var.app_approle_name
  token_ttl = "32400000"
  token_max_ttl = "32400000"
  bind_secret_id = true
  token_policies = [vault_policy.app_policy.name]
}

# Create an Secret_id

resource "vault_approle_auth_backend_role_secret_id" "app_secret_id" {
  backend   = vault_approle_auth_backend_role.app_approle.backend
  role_name = vault_approle_auth_backend_role.app_approle.role_name
}

# Create an Client Token

resource "vault_approle_auth_backend_login" "login" {
  backend   = vault_approle_auth_backend_role.app_approle.backend
  role_id   = vault_approle_auth_backend_role.app_approle.role_id
  secret_id = vault_approle_auth_backend_role_secret_id.app_secret_id.secret_id
}

# Create an Parameter
resource "aws_ssm_parameter" "app_token_parameter" {
  name      = var.token_parameter_name
  description = "Client token for application"
  type      = "SecureString"
  value     = vault_approle_auth_backend_login.login.client_token
  overwrite = true
}

resource "aws_ssm_parameter" "app_env_parameter" {
  name      = var.app_parameter_name
  description = "Env path for application"
  type      = "String"
  value     = var.app_parameter_value
  overwrite = true
}


