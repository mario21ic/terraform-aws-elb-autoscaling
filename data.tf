data "aws_ami" "my_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["${var.ami}"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}