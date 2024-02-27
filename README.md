# Games Shelf: Infrastructure Repository

This repository is to manage the infrastructure of the Games Shelf application, including all of the resources related to the following components:
- Web API
- Web App
- Mobile App

The primary tool being used to manage the infrastructure on AWS is Terraform.

## Dependencies

- Terraform 1.7.0 or newer
- AWS IAM credentials profile named `games-shelf`

## Important Information

### Manually Provisioned Resources

 _Warning:_ As you'll see under `NON-TF RESOURCES` in `main.tf`, there are some resources that must be created manually.

 Be sure to check that these resources are present if you're deploying a new environment or having issues.

## State

Terraform state is managed using the AWS S3 backed with a DynamoDB table used for state locking:
- S3 Bucket - `games-shelf-<environment>-terraform-state`
- DynamoDB Table - `games-shelf-<environment>-terraform-state`

> Note: These two resources are created manually and are not managed by terraform, as it shouldn't manage it's own dependencies.

## Run

Init the project (install AWS plugins, etc.)

```
terraform init -upgrade
```

Plan changes (outputs to the file ./changestomake)

```
terraform plan -out changestomake
```

Apply changes (once you've reviewed tha plan and are sure it's safe)

```
terraform apply changestomake
```
