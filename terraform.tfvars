region = "eu-west-1"

name = "draft"

key_name = "mykeypair"

vpc_id = "vpc-ec170488"

iam_instance_profile = "EC2Development"

security_group_admin = "sg-cc23f5b5"
public_subnets = ["subnet-ab978fxx", "subnet-ecabb3xx"]
private_subnets = ["subnet-aa978fxx", "subnet-edabb3xx"]

instance_type = "t2.micro"

max_size = 4

min_size = 2

desired_capacity = 2

ami = "my_nginx"
