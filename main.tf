/*
NON-TF RESOURCES

These resources were/must be created manually.

* S3 Bucket for terraform state
* DynamoDB Table for terraform state lock

*/

locals {
  webapi_suffix = "${var.env}-webapi"
}

provider "aws" {
  region  = var.region
  profile = var.profile
}

terraform {
  backend "s3" {
    bucket          = "games-shelf-dev-terraform-state"
    key             = "games-shelf-dev.tfstate"
    region          = "us-west-2"
    profile         = "games-shelf"
    dynamodb_table  = "games-shelf-dev-terraform-state"
    encrypt         = true
  }
}

resource "aws_dynamodb_table" "games-shelf-table" {
  name            = "games-shelf-${local.webapi_suffix}"
  billing_mode    = "PROVISIONED"
  hash_key        = "PartitionKey"
  range_key       = "SortKey"

  read_capacity   = 1
  write_capacity  = 1

  attribute {
    /*
    * This is dynamic and based on the "product" in question
    * The documentation repo has a class diagram that shows the different document types
    * An example of the PartitionKey for game ranks is:
    * "GAMERANK#BGG"
    */
    name = "PartitionKey"
    type = "S"
  }

  attribute {
    /*
    * This is dynamic and based on both the "product" the document is a part of, and the "type" of document it is
    * The documentation repo has a class diagram that shows the different document types
    * An example of the SortKey pattern, and an example for a SortKey, for game ranks is:
    * "[GAME_NAME]#[BGG_ID]#GAME"
    * "CATAN#13#GAME"
    */
    name = "SortKey"
    type = "S"
  }
}