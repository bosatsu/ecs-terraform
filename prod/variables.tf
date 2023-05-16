variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-west-2"
}

variable "aws_profile" {
  description = "AWS profile"
}

variable "stack_name" {
  description = "Prepend name for stack resources."
}

variable "task_name" {
  description = "Prepend name for ECS Fargate task resources."
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default    = "172.17.0.0/16"
}

variable "container_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 8080
}

variable "az_count" {
  description = "Number of AZs to cover in a given AWS region"
  default     = 2
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = 1024
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = 2048
}
