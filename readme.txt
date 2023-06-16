# Terraform RDS Instance Creation Scripts

This repository contains Terraform scripts for creating instances through Amazon Managed Database Service called RDS. The scripts support the creation of instances for popular relational database management systems (RDBMS) like MySQL, PostgreSQL, and MongoDB.

## Prerequisites

Before using these scripts, make sure you have the following prerequisites set up:

1. **Terraform**: Install Terraform on your local machine. You can download it from the official Terraform website: [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html).

2. **AWS Account**: Create an AWS account if you don't have one already. You will need AWS access and secret keys to configure Terraform with your account. Make sure you have the necessary permissions to create RDS instances.

## Configuration

1. Clone this repository to your local machine.
2. Open the desired RDBMS script file (e.g., `mysql.tf` for MySQL, `postgresql.tf` for PostgreSQL, `mongodb.tf` for MongoDB) using a text editor.
3. Customize the script to match your requirements by modifying the configuration parameters (e.g., instance size, storage, database name, username, and password).
4. Save the changes to the script file.

## Usage

To create an RDS instance using Terraform:

1. Initialize the Terraform configuration by running `terraform init` command.
2. Review the planned changes by running `terraform plan` command.
3. If the plan looks good, apply the changes by running `terraform apply` command.
4. Confirm the creation of resources by entering `yes` when prompted.
5. Wait for Terraform to provision the RDS instance. It may take a few minutes.
6. Once the instance is created, Terraform will display the output, including the endpoint URL, username, and password for accessing the RDS instance.

## Clean Up

To destroy the RDS instance and associated resources:

1. Run `terraform destroy` command.
2. Confirm the destruction of resources by entering `yes` when prompted.
3. Terraform will proceed to destroy the RDS instance and any associated resources. Please note that this action cannot be undone.

## Disclaimer

These Terraform scripts are provided as-is and without warranty. Use them at your own risk. Make sure to review and customize the scripts according to your specific requirements and best practices.

## License

This repository is licensed under the [MIT License](LICENSE). Feel free to modify and distribute the scripts as needed.

For more information on Terraform and Amazon RDS, refer to the official documentation:

- Terraform: [https://www.terraform.io/docs/index.html](https://www.terraform.io/docs/index.html)
- Amazon RDS: [https://aws.amazon.com/rds/](https://aws.amazon.com/rds/)

Happy infrastructure provisioning!
