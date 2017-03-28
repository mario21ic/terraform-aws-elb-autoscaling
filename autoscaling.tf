resource "aws_cloudwatch_metric_alarm" "cpu-high" {
  alarm_name = "cpu-util-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "300"
  statistic = "Average"
  threshold = "70"
  alarm_description = "This metric monitors ec2 cpu for high utilization on agent hosts"
  alarm_actions = [
    "${aws_autoscaling_policy.agents-scale-up.arn}"
  ]
  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.aug_def.name}"
  }
}

resource "aws_autoscaling_policy" "agents-scale-up" {
  name = "agents-scale-up"
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 300

  autoscaling_group_name = "${aws_autoscaling_group.aug_def.name}"
}

resource "aws_cloudwatch_metric_alarm" "cpu-low" {
  alarm_name = "cpu-util-low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "1"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "300"
  statistic = "Average"
  threshold = "70"
  alarm_description = "This metric monitors ec2 cpu for low utilization on agent hosts"
  alarm_actions = [
    "${aws_autoscaling_policy.agents-scale-down.arn}"
  ]
  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.aug_def.name}"
  }
}
resource "aws_autoscaling_policy" "agents-scale-down" {
  name = "agents-scale-down"
  scaling_adjustment = -1
  adjustment_type = "ChangeInCapacity"
  cooldown = 300

  autoscaling_group_name = "${aws_autoscaling_group.aug_def.name}"
}

resource "aws_autoscaling_group" "aug_def" {
  name                 = "asg_${var.name}"
  launch_configuration = "${aws_launch_configuration.lc_def.name}"

  # Private subnets
  vpc_zone_identifier = "${var.private_subnets}"

  load_balancers = ["${aws_elb.my_elb.name}"]

  max_size = "${var.max_size}"
  min_size = "${var.min_size}"
  desired_capacity = "${var.desired_capacity}"

  force_delete = true
  lifecycle {
    create_before_destroy = true
  }

  enabled_metrics = [
    "GroupInServiceInstances",
    "GroupMinSize",
    "GroupDesiredCapacity",
    "GroupPendingInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
    "GroupMaxSize",
    "GroupStandbyInstances"
  ]
}