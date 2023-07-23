# Terraform

Terraform config for quickly setting up a new AWS environment

This is a platform to build on but gives an initial start to provisioning with Terraform


## Resources Provisioned

### IAM

#### Groups and Policies
- Elevated Devlopers
- Standard Developer
- Billing Agent

#### Users
- Elevated Devloper (1)
- Developer(1)
- Billing Agent (1)

### Dynamo DB

Table (dev_terraform_lock)
Billing (Pay Per Request)

### S3

## Variables to Change

### Region

### Backend Config




## Quickstart

1) To begin with, the intial_backend_config.tf needs to be used to allow Terraform to store config files locally (these will be moved later)
2) Move "terraform_backend_config.tf" out of the "src" directory
3) terraform init
4) terraform plan
5) terraform apply
6) Remove the "initial_backend_config.tf" and replace with "terraform_backend_config.tf"
7) terraform init
8) Agree to moving the config to S3