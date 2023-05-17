output "alb_dns" {
  description = "DNS name for the ALB"
  value = aws_alb.alb.dns_name
}

output "alb_tg_id" {
  description = "ID of the target group for the ALB"
  value = aws_alb_target_group.target_group.id
}

output "alb_listener" {
  description = "ALB Listener Object"
  value = aws_alb_listener.alb-listener
}
