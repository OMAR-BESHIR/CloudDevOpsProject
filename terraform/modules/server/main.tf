data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_security_group" "jenkins_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_instance" "jenkins_server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.jenkins_sg.id]
  associate_public_ip_address = true
  key_name                    = var.key_name
  user_data                   = file("${path.module}/user_data.sh")

  
  tags = {
    Name = "Jenkins-Server"
  }
}    

resource "aws_sns_topic" "user_updates" {
  name = "jenkins-cpu-alerts"
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.user_updates.arn
  protocol  = "email"
  endpoint  = "obeshir306@gmail.com"
}
resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name                = "jenkins-cpu-high"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 120
  statistic                 = "Average"
  threshold                 = 80
  alarm_description         = "This metric monitors ec2 cpu utilization"
  alarm_actions             = [aws_sns_topic.user_updates.arn]
  ok_actions                = [aws_sns_topic.user_updates.arn]
  
  dimensions = {
    InstanceId = aws_instance.jenkins_server.id
  }
}  