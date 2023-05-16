output "iam_role_arn" {
  description = "The ARN of the IAM role for the Fargate task"
  value       = aws_iam_role.tasks-service-role.arn
}
