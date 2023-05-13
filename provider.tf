provider "aws" {
  profile = "bosatsu"
  region  = "${var.aws_region}"
}

terraform {
  backend "s3" {
    bucket = "tf-backend-spage"
    key    = "ecs-cluster"
    region  = "us-west-2"
    profile = "bosatsu"
  }
}

