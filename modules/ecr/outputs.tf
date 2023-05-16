output "ecr_repo_url" {
  value = aws_ecr_repository.main.repository_url
}

output "ecr_repo_arn" {
  value = aws_ecr_repository.main.arn
}
