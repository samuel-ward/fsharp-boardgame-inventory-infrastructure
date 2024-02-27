/*
NON-TF RESOURCES

These resources were/must be created manually.

* S3 Bucket for terraform state
* DynamoDB Table for terraform state lock

*/

provider "aws" {
  region  = var.region
  profile = var.profile
}

terraform {
  backend "s3" {
    bucket  = "games-shelf-dev-terraform-state"
    key     = "games-shelf-dev.tfstate"
    region  = "us-west-2"
    profile = "games-shelf"
    dynamodb_table  = "games-shelf-dev-terraform-state"
    encrypt = true
  }
}
