resource "aws_launch_template" "testlaunch" {
  name          = "new-launch"
  key_name      = "abdu_24"
  image_id      = "ami-0e4bd026c1aaf16eb"
  instance_type = "t2.micro"
  user_data = filebase64("install_httpd.sh")
  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.webservers.id]
  }
}
resource "aws_autoscaling_group" "autoscal" {
  name = "terra-auto"
  min_size         = 1
  max_size         = 3
  desired_capacity = 1
  vpc_zone_identifier = aws_subnet.public[*].id
  launch_template {
    id      = aws_launch_template.testlaunch.id
    version = "$Latest"
  }
  load_balancers = [aws_elb.terra-elb.name]
}
resource "aws_autoscaling_policy" "cpu" {
  autoscaling_group_name = aws_autoscaling_group.autoscal.name
  name                   = "cpu"
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50
  }
  depends_on = [aws_autoscaling_group.autoscal]
}
