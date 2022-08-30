# Using this remote data source, we are fetching the outputs from remote state file. in this case VPC Statefile
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config {
    bucket = "b49-rf-remote-state-bucket"
    key    = "vpc/${var.ENV}/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "terraform-state-prod"
    key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}