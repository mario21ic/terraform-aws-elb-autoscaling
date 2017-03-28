resource "aws_launch_configuration" "lc_def" {
  name          = "lc_${var.name}"
  image_id      = "${data.aws_ami.my_ami.id}"
  instance_type = "${var.instance_type}"

  key_name      = "${var.key_name}"

  security_groups = ["${aws_security_group.sg_lc.id}"]
  iam_instance_profile   = "${var.iam_instance_profile}"

  root_block_device {
    volume_size           = "8"
    volume_type           = "gp2"
    delete_on_termination = "true"
  }
}

resource "aws_security_group" "sg_lc" {
  name        = "sg_lc_${var.name}"
  description = "Autoscaling inbound and outbound"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = ["${var.security_group_admin}"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "sg_lc_${var.name}"
    Class       = "sg_lc_${var.name}"
    Enviroment  = "${var.environment}"
    Description = "Launch configuration ${var.name} security group"
  }
}
