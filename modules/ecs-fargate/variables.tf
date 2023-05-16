variable "stack_name" {
  description = "Prepend name for stack resources."
}

variable "task_name" {
  description = "Prepend name for ECS Fargate task resources."
}

variable "private_subnet_ids" {
  description = "IDs for the private subnets in the VPC"
}

variable "task_sg_id" {
  description = "ID for the ECS Fargate Task Security Group"
}

variable "alb_tg_id" {
  description = "ID of the target group for the ALB"
}

variable "alb_listener" {
  description = "ALB Listener Object"
}

variable "iam_role_arn" {
  description = "The ARN of the IAM role for the Fargate task."
}

variable "ecr_repo_url" {
  description = "The ARN of the ECR Repo for the Fargate task."
}

variable "task_count" {
  description = "Number of ECS tasks to run"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
}

variable "container_port" {
  description = "Port exposed by the docker image to redirect traffic to"
}
