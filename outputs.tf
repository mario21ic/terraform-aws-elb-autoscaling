output "elastic_load_balancer_id" {
  value = "${aws_elb.my_elb.id}"
}

output "elastic_load_balancer_dns_name" {
  value = "${aws_elb.my_elb.dns_name}"
}

output "autoscaling_group_id" {
  value = "${aws_autoscaling_group.aug_def.id}"
}

output "launch_configuration_id" {
  value = "${aws_launch_configuration.lc_def.id}"
}

output "security_group_lc_id" {
  value = "${aws_security_group.sg_lc.id}"
}

output "security_group_elb_id" {
  value = "${aws_security_group.sg_elb.id}"
}