variable "stack_name" {
  description = "Prepend name for stack resources."
}

variable "vpc_id" {
  description = "ID for the VPC"
}

variable "alb_sg_id" {
  description = "ID for the ALB Security Group"
}

variable "public_subnet_ids" {
  description = "IDs for the public subnets in the VPC"
}
