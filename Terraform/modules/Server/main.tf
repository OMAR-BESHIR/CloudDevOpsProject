resource "aws_security_group" "web_sg" {
  name        = "${var.project}-sg"
  description = "Allow web traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-sg"
  }
}

resource "aws_instance" "server" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = element(var.public_subnets, 0)
  security_groups = [aws_security_group.web_sg.id]

  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    apt update -y
    apt install -y docker.io
    systemctl enable docker
    systemctl start docker
  EOF

  tags = {
    Name = "${var.project}-ec2"
  }
}

