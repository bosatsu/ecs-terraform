# ---------------------------------------------------------------------------------------------------------------------
# ECS CLUSTER
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_ecs_cluster" "ecs-cluster" {
  name = "${var.stack_name}-ecs-cluster"
}

# ---------------------------------------------------------------------------------------------------------------------
# ECS TASK DEFINITION USING FARGATE
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_ecs_task_definition" "task-def" {
  family                   = "${var.task_name}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = var.iam_role_arn
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions = jsonencode([
    {
      name      = "${var.task_name}"
      image     = "${var.ecr_repo_url}"
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
  name            = "${var.stack_name}-ecs-service"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.task-def.arn
  desired_count   = var.task_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = [var.task_sg_id]
    subnets         = var.private_subnet_ids
  }

  load_balancer {
    target_group_arn = var.alb_tg_id
    container_name   = "${var.task_name}"
    container_port   = var.container_port
  }

  depends_on = [
    var.alb_listener,
  ]

  lifecycle {
    ignore_changes = [
      # Ignore changes to task_definition because these are expected to be managed by the customer, but are required for terraform
      task_definition,
    ]
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CLOUDWATCH LOG GROUP
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name = "${var.stack_name}-ecs-cloudwatch"
}
