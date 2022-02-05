
resource "aws_autoscaling_group" "webserver" {
  name = "${var.PROJECT_NAME}-asg-webserver"
  max_size = 5
  min_size = 2
  health_check_grace_period = 30
  health_check_type = "EC2"
  desired_capacity = 2
  force_delete = true
  launch_configuration = "${aws_launch_configuration.for_webserver.name}"
  vpc_zone_identifier = ["${aws_subnet.public_subnet_1.id}", "${aws_subnet.public_subnet_2.id}"]
  target_group_arns = ["${aws_alb_target_group.back_end.arn}"]

}
