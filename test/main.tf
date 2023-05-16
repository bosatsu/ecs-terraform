provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
}

terraform {
  backend "s3" {}
}

module "vpc_test" {
  source = "../modules/vpc"
  stack_name = "${var.stack_name}"
  vpc_cidr = var.vpc_cidr
  az_count = var.az_count
}

module "sg_test" {
  source = "../modules/security-groups"
  stack_name = "${var.stack_name}"
  vpc_id = module.vpc_test.vpc_id
  vpc_cidr = var.vpc_cidr
  container_port = var.container_port
}

module "alb_test" {
  source = "../modules/alb"
  stack_name = "${var.stack_name}"
  vpc_id = module.vpc_test.vpc_id
  alb_sg_id = module.sg_test.alb_sg_id
  public_subnet_ids = module.vpc_test.public_subnet_ids
}

module "iam_fargate_test" {
  source = "../modules/iam-fargate"
  stack_name = "${var.stack_name}"
}

module "ecr_test" {
  source = "../modules/ecr"
  stack_name = "${var.stack_name}"
}

module "ecs_fargate_test" {
  source = "../modules/ecs-fargate"
  stack_name = "${var.stack_name}"
  task_name = "${var.task_name}"
  private_subnet_ids = module.vpc_test.private_subnet_ids
  task_sg_id = module.sg_test.task_sg_id
  alb_tg_id = module.alb_test.alb_tg_id
  alb_listener = module.alb_test.alb_listener
  iam_role_arn = module.iam_fargate_test.iam_role_arn
  ecr_repo_url = module.ecr_test.ecr_repo_url
  task_count = var.az_count
  fargate_cpu = var.fargate_cpu
  fargate_memory = var.fargate_memory
  container_port = var.container_port
}
