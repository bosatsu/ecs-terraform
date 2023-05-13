# ---------------------------------------------------------------------------------------------------------------------
# ECS CLUSTER
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_ecs_cluster" "ecs-cluster" {
  name = "${var.stack}-Cluster"
}

# ---------------------------------------------------------------------------------------------------------------------
# ECS TASK DEFINITION USING FARGATE
# ---------------------------------------------------------------------------------------------------------------------

# resource "aws_ecs_task_definition" "petclinic_taskdef" {
#   family                = "petclinic"
#   container_definitions = "${data.template_file.petclinic-container.rendered}"

#   lifecycle {
#     create_before_destroy = true
#   }
# }


resource "aws_ecs_task_definition" "task-def" {
  family                   = var.family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.tasks-service-role.arn
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
#  task_role_arn            = "${aws_iam_role.ecs-tasks-service-role.arn}"
  # container_definitions = data.template_file.petclinic-container.rendered
  # container_definitions = file("petclinic.json")
  container_definitions = jsonencode([
    {
      name      = "${var.family}"
      image     = "${aws_ecr_repository.image_repo.repository_url}"
      cpu       = var.fargate_cpu
      memory    = var.fargate_memory
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
        }
      ]
    },
  ])
}

# ---------------------------------------------------------------------------------------------------------------------
# ECS SERVICE
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_ecs_service" "service" {
  name            = "${var.stack}-Service"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.task-def.arn
  desired_count   = var.task_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [aws_security_group.task-sg.id]
    subnets         = aws_subnet.private.*.id
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.trgp.id
    container_name   = var.family
    container_port   = var.container_port
  }

  depends_on = [
    aws_alb_listener.alb-listener,
  ]

  lifecycle {
    ignore_changes = [
      # Ignore changes to cpu, memory and container definitions because these are expected
      # to be managed by the customer, but are required for terraform
      task_definition,
    ]
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CLOUDWATCH LOG GROUP
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_cloudwatch_log_group" "petclinic-cw-lgrp" {
  name = var.cw_log_group
}
