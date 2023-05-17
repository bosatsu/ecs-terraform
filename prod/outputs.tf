output "alb_address" {
  value = module.alb_prod.alb_dns
}

output "iam_role_arn" {
  value       = module.iam_fargate_prod.iam_role_arn
}

output "ecr_repo_url" {
  value = module.ecr_prod.ecr_repo_url
}
