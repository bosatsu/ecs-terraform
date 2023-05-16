output "alb_sg_id" {
  description = "The ID of the Security Group for the ALB"
  value       = aws_security_group.alb-sg.id
}

output "task_sg_id" {
  description = "The ID of the Security Group for the ALB"
  value       = aws_security_group.task-sg.id
}
