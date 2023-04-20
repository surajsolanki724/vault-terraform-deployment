pipeline {
    agent "terraform-node"

    environment {
        VAULTSECRET = "vault-secret"
    }

     parameters {
        string(name: "Project_Name", defaultValue: "", description: "Project Name. E.g.: ")
        choice(name: "Environment", choices: ["dev", "prod"], description: "Deploy Vault Resources in given environment.")
    }

    stages {
        stage('Pre-Build') {
            environment {
                VAULT = credentials("${env.VAULTSECRET}")

            }
            steps {

                sh """ 
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
               """
            }
        }

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
          
            steps {
                sh """
                terraform workspace new ${params.Project_Name}-${params.Environment}
                terraform plan -var-file=app.tfvars -out=tfplan'
                """
            }
        }

        stage('Terraform Apply') {
           
            steps {
                input 'Do you want to proceed with the deployment?'
                sh 'terraform apply tfplan -var-file=app.tfvars'

                script {
                    if (currentBuild.result == 'SUCCESS') {
                        sh """
                        if [ $? -eq 1 ]; then
                        //backup
                        """
                    } else {
                        sh """
                        terraform workspace delete ${params.Project_Name}-${params.Environment}
                        terraform destroy -auto-approve
                        """
                    }
                }
            }
        }
    }
}
