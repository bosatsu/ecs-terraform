variable "stack_name" {
  description = "Prepend name for stack resources."
}

variable "vpc_id" {
  description = "ID for the VPC"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
}

variable "container_port" {
  description = "Port exposed by the docker image to redirect traffic to"
}
