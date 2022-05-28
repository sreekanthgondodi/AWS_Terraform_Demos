
###Application load balancer for app server
resource "aws_lb" "front_end" {
  name               = "${var.PROJECT_NAME}-Frontend-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.appservers_alb.id}"]
  subnets            = ["${aws_subnet.public_subnet_2.id}","${aws_subnet.public_subnet_1.id}"]

}

# Adding HTTP listener
resource "aws_lb_listener" "webserver" {
  load_balancer_arn = "${aws_lb.front_end.arn}"
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = "${aws_lb_target_group.front_end.arn}"
    type             = "forward"
  }
}

# Add Target Group
resource "aws_lb_target_group" "front_end" {
  name     = "Target-Group-for-frontend"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.main.id}"
}
output "Web Server_Load_Balancer_Endpoint" {
  value = "${aws_lb.front_end.dns_name}"
}
