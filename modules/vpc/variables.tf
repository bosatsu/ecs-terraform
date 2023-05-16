variable "stack_name" {
  description = "Prepend name for stack resources."
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
}

variable "az_count" {
  description = "Number of AZs to cover in a given AWS region"
}
