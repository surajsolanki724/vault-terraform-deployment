#!/bin/bash
set -x
source $VAULTCREDS

touch terraform.tfvars

echo vault_address="\"$VAULT_ADDRESS"\" >> terraform.tfvars
echo vault_username="\"$VAULT_USERNAME"\">> terraform.tfvars
echo vault_password="\"$VAULT_PASSWORD"\">> terraform.tfvars
echo aws_region="\"$AWS_REGION"\">> terraform.tfvars

touch app.tfvars

echo app_secret_path="\"secret/$Environment/$Project_Name"\">> app.tfvars
echo app_secret_policy_path="\"secret/data/$Environment/$Project_Name"\">> app.tfvars
echo app_policy_name="\"$Project_Name-$Environment-policy"\">> app.tfvars
echo app_approle_name="\"$Project_Name-$Environment-role"\">> app.tfvars
echo token_parameter_name="\"/$Project_Name/$Environment/VAULT_TOKEN"\">> app.tfvars
echo app_parameter_name="\"/$Project_Name/$Environment/ENV_PATH"\">> app.tfvars
echo app_parameter_value="\"$Environment/$Project_Name"\">> app.tfvars

cp terraform.tfvars terraform.tfvars.tmp
sed $'s/[^[:print:]\t]//g' terraform.tfvars.tmp > terraform.tfvars 


terraform init

terraform workspace new $Project_Name-$Environment
if [ $? -eq 1 ]; then
    echo "Terraform workspace already exist"
    terraform workspace select $Project_Name-$Environment
fi

terraform apply  -var-file=app.tfvars -auto-approve

if [ $? -eq 1 ]; then
    echo "Terraform plan/apply failed"
    terraform destroy -auto-approve
    terraform workspace delete $Project_Name-$Environment
    exit 1
else
    echo "Terraform apply successfull"
    DIR=~/terraform_vault_backups/$Project_Name-$Environment
    if [ -d "$DIR" ]; then
    	mkdir -p $DIR/backup
    	cp app.tfvars "$DIR"
    else
    	mkdir -p "$DIR"
    	cp app.tfvars "$DIR"
    	
    fi   
fi