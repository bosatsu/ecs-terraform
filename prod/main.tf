provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_profile}"
}

terraform {
  backend "s3" {}
}

module "vpc_prod" {
  source = "../modules/vpc"
  stack_name = "${var.stack_name}"
  vpc_cidr = var.vpc_cidr
  az_count = var.az_count
}

module "sg_prod" {
  source = "../modules/security-groups"
  stack_name = "${var.stack_name}"
  vpc_id = module.vpc_prod.vpc_id
  vpc_cidr = var.vpc_cidr
  container_port = var.container_port
}

module "alb_prod" {
  source = "../modules/alb"
  stack_name = "${var.stack_name}"
  vpc_id = module.vpc_prod.vpc_id
  alb_sg_id = module.sg_prod.alb_sg_id
  public_subnet_ids = module.vpc_prod.public_subnet_ids
}

module "iam_fargate_prod" {
  source = "../modules/iam-fargate"
  stack_name = "${var.stack_name}"
}

module "ecr_prod" {
  source = "../modules/ecr"
  stack_name = "${var.stack_name}"
}

module "ecs_fargate_prod" {
  source = "../modules/ecs-fargate"
  stack_name = "${var.stack_name}"
  task_name = "${var.task_name}"
  private_subnet_ids = module.vpc_prod.private_subnet_ids
  task_sg_id = module.sg_prod.task_sg_id
  alb_tg_id = module.alb_prod.alb_tg_id
  alb_listener = module.alb_prod.alb_listener
  iam_role_arn = module.iam_fargate_prod.iam_role_arn
  ecr_repo_url = module.ecr_prod.ecr_repo_url
  task_count = var.az_count
  fargate_cpu = var.fargate_cpu
  fargate_memory = var.fargate_memory
  container_port = var.container_port
}
