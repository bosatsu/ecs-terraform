# ---------------------------------------------------------------------------------------------------------------------
# ECR
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_ecr_repository" "main" {
  name                 = "${var.stack_name}-ecr-repo"
  image_tag_mutability = "MUTABLE"
  force_delete = "true"
  #  image_scanning_configuration {
  #    scan_on_push = true
  #  }
}
