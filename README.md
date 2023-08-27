# Terraform AWS Template

![Static Badge](https://img.shields.io/badge/Terraform-=>v1.5.3-blue)
![Static Badge](https://img.shields.io/badge/License-MIT-yellow)
![Static Badge](https://img.shields.io/badge/AWS-green)

## Description

This Terraform configuration is for an initial AWS account to get you started quickly. It implements some basic functionality of using an S3 hosted state file rather than having them hosted on a local machine.

Using S3 for storing the Terraform configuration allows for the state file to be modified by anyone with the correct permissions to do so. Having it stored centrally on the cloud also removes all of the short comings with having it stored on a single developers machine, including accidental deletion and a lack of version control. 

### Resources Provisioned

#### IAM

- Groups
    - Standard Developers
        - Billing and Terraform access is blocked
    - Elevated Developers
        - Billing is blocked, everything else is allowed (inc. Terraform modification)
    - Billing
        - Only Billing is allowed

#### Dynamo DB

- Table - dev_terraform_lock
- Billing mode - Pay Per Request

#### S3
- Bucket - 
    - Encryption - AES 256
    - Versioning - Enabled
    - Key Storage - Dynamo DB

## Disclaimer

It is highly recommended to view the policy permissions before setting up this environment as they might not perfectly match your requirments. This is only a baseline template for setting the environment up and should not be immediately used for any active environment in it's current state.

## Prerequisites

- Terraform >= 1.5.3

## Dependancies

### AWS
- S3
- Dynamo DB
- IAM


## Usage

```
git clone https://github.com/BenjaminN117/Terraform-Template-AWS.git
```

The "src/initial_config/initial_provider_config.tf" needs to be used prior to moving the environment to S3. Move the "src/provider.tf" out of the "src/" directory and replace with the "initial_provider_config.tf".

```
terraform init
```

```
terraform plan
```

```
terraform apply
```

Remove the "initial_provider_config.tf" from the src directory and replace with the original "provider.tf" file.

```
terraform init
```

Agree to moving the terraform state file to S3.

## Run tests

```
terraform validate
```

```
terraform plan
```