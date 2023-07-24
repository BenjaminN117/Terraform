# Terraform

Terraform config for quickly setting up a new AWS environment

This is a platform to build on but gives an initial start to provisioning with Terraform.

## Resources Provisioned

### IAM

#### Groups and Policies
- Elevated Devlopers
    - Billing is blocked 
- Standard Developer
    - Terraform S3 and billing is blocked  
- Billing Agent
    -   Only billing is allowed

### Dynamo DB

Table (dev_terraform_lock)
Billing (Pay Per Request)

### S3

S3 bucket for Terraform backend config (bucket name needs to be changed)

## Quickstart

1) To begin with, the intial_provider_config.tf needs to be used to allow Terraform to store config files locally (these will be moved later)
2) Move "provider.tf" out of the "src" directory
3) terraform init
4) terraform plan
5) terraform apply
6) Remove the "initial_provider_config.tf" and replace with "provider.tf"
7) terraform init
8) Agree to moving the config to S3