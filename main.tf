terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
resource "aws_ecr_repository" "demo-repository" {
  name                 = "phani-demo-repo"
  image_tag_mutability = "IMMUTABLE"
}

resource "aws_ecr_repository_policy" "demo-repo-policy" {
  repository = aws_ecr_repository.demo-repository.name
  policy     = <<EOF
  {
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "adds full ecr access to the demo repository",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetLifecyclePolicy",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
      }
    ]
  }
  EOF
  

}
resource "null_resource" "push" {
  provisioner "local-exec" {
    
    command = "bash docker_build_push.sh  ${aws_ecr_repository.demo-repository.repository_url}:latest ${aws_ecr_repository.demo-repository.repository_url} "
  }

}
resource "aws_ecs_cluster" "ecs_cluster" {
    name  = "phani-demo-cluster"
}
resource "aws_ecs_task_definition" "task_definition" {
  family                = "worker"
  container_definitions = data.template_file.task_definition_template.rendered
}
resource "aws_ecs_service" "worker" {
  name            = "worker"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = 2
}
