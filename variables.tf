variable "region" {
  description = "aws region"
}

variable "name" {
  description = "elb name"
}

variable "ami" {
  description = "ami name"
}

variable "key_name" {
  description = "Key name"
}

variable "security_group_admin" {
  description = "Security group admin"
}

variable "vpc_id" {
  description = "vpc id"
}

variable "iam_instance_profile" {
  type        = "string"
  description = "iam profile"
}

variable "public_subnets" {
  type        = "list"
  description = "Subnets available"
}

variable "private_subnets" {
  type        = "list"
  description = "Subnets available"
}

variable "instance_type" {
  description = "Instance type"
}

variable "desired_capacity" {
  description = "Desired capacity"
}

variable "max_size" {
  description = "Max size"
}

variable "min_size" {
  description = "Min size"
}
