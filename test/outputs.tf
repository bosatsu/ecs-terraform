output "alb_address" {
  value = module.alb_test.alb_dns
}

output "iam_role_arn" {
  value       = module.iam_fargate_test.iam_role_arn
}

output "ecr_repo_url" {
  value = module.ecr_test.ecr_repo_url
}
