provider "aws" {
  region = var.region
  profile = var.profile

  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/${var.iam_role_name}"
  }
}



module "db_instance" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "${var.env}-postgresql"

  engine            = "postgres"
  engine_version    = "13.3"
  instance_class    = "db.t2.small"
  allocated_storage = 20

  name     = "${var.env}_db"
  username = var.username
  password = var.password
  port     = "5432"

  iam_database_authentication_enabled = true

  parameter_group_name = aws_db_parameter_group.default.name

  vpc_security_group_ids = [aws_security_group.default.id]

  tags = {
    Environment = var.env
  }

  multi_az               = false
  backup_window          = "07:00-09:00"
  backup_retention_period = 2

  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
}

resource "aws_security_group" "default" {
  name        = "${var.env}-rds-security-group"
  description = "Managed by Terraform for RDS instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_parameter_group" "default" {
  name        = "${var.env}-rds-param-group"
  family      = "postgres13"
  description = "Managed by Terraform for RDS instance"

  parameter {
    name  = "example_parameter" #Based on the Parameter  requirement you can use
    value = "example_value" # Value Accordingly
  }
}

resource "aws_iam_role" "role" {
  name = "${var.env}-rds-access-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "rds.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_cloudwatch_metric_alarm" "cpu_alert" {
  alarm_name          = "rds-cpu-utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = "60"
  statistic           = "Average"
  threshold           = "70"
  alarm_description   = "This metric checks cpu utilization"
  alarm_actions       = [aws_sns_topic.cpu_alert.arn]
  dimensions = {
    DBInstanceIdentifier = module.db_instance.this_db_instance_id
  }
}

resource "aws_sns_topic" "cpu_alert" {
  name = "${var.env}-rds-notification"
}

variable "env" {}
variable "region" {}
variable "profile" {}
variable "username" {}
variable "password" {}
variable "vpc_id" {}


