[
  {
    "essential": true,
    "memory": 512,
    "name": "worker",
    "cpu": 2,
    "image": "${aws_ecr_repository.demo-repository.repository_url}:latest",
    "environment": []
  }
]
