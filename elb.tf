# Create a new load balancer
resource "aws_elb" "terra-elb" {
  name               = "terra-elb"
  subnets = aws_subnet.public.*.id
  security_groups = [aws_security_group.webservers.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/index.html"
    interval            = 30
  }


  tags = {
    Name = "terraform-elb"
  }
}

output "elb-dns-name" {
  value = aws_elb.terra-elb.dns_name
}

