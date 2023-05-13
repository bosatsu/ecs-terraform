# ---------------------------------------------------------------------------------------------------------------------
# VARIABLES
# ---------------------------------------------------------------------------------------------------------------------

variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-west-2"
}

variable "aws_profile" {
  description = "AWS profile"
}

variable "stack" {
  description = "Prepend name for stack resources."
}

variable "family" {
  description = "Family of the Task Definition"
}

variable "image_repo_name" {
    description = "Image repo name"
}

variable "cw_log_group" {
  description = "CloudWatch Log Group"
}

variable "fargate-task-service-role" {
  description = "Name of the stack."
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default    = "172.17.0.0/16"
}

variable "az_count" {
  description = "Number of AZs to cover in a given AWS region"
  default     = 3
}

variable "container_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 8080
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = 1024
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = 2048
}

variable "task_count" {
  description = "Number of ECS tasks to run"
  default     = 3
}
