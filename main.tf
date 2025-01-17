resource "aws_vpc" "main" {
  cidr_block = "20.10.0.0/16"
  enable_dns_support = true

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public-2a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "20.10.1.0/24"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true

    tags = {
        Name = "public-2a"
    }
}

resource "aws_subnet" "public-2b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "20.10.2.0/24"
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = true
    
    tags = {
        Name = "public-2b"
    }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
    }
}

resource "aws_route_table_association" "public-2a" {
  subnet_id      = aws_subnet.public-2a.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "public-2b" {
  subnet_id      = aws_subnet.public-2b.id
  route_table_id = aws_route_table.main.id
}

resource "aws_security_group" "main" {
  vpc_id = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "main"
    }
}

resource "aws_instance" "main1" {
  ami           = "ami-05d38da78ce859165"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public-2a.id
  vpc_security_group_ids = [aws_security_group.main.id]
  user_data = base64encode(file("user_data1.sh"))
  
  tags = {
    Name = "Server1"
  }
}


resource "aws_instance" "main2" {
  ami           = "ami-05d38da78ce859165"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public-2b.id
  vpc_security_group_ids = [aws_security_group.main.id]
  user_data = base64encode(file("user_data2.sh"))
  
  tags = {
    Name = "Server2"
  }
}

resource "aws_lb" "test" {
    name = "my-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.main.id]
    subnets = [aws_subnet.public-2a.id, aws_subnet.public-2b.id]

    tags = {
        Name = "my-alb"
    }
}   

resource "aws_lb_target_group" "test" {
    name = "my-target-group"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.main.id

    health_check {
        path = "/"
        port = "traffic-port"
        protocol = "HTTP"
    }

    tags = {
        Name = "my-target-group"
    }
}

resource "aws_lb_listener" "test" {
    load_balancer_arn = aws_lb.test.arn
    port = "80"
    protocol = "HTTP"

    default_action {
        target_group_arn = aws_lb_target_group.test.arn
        type = "forward"
    }
}

resource "aws_lb_listener_rule" "test" {
    listener_arn = aws_lb_listener.test.arn
    action {
        type = "forward"
        target_group_arn = aws_lb_target_group.test.arn
    }

    condition {
        host_header {
            values = ["example.com"]
        }
    }
}

resource "aws_alb_target_group_attachment" "attach1" {
    target_group_arn = aws_lb_target_group.test.arn
    target_id = aws_instance.main1.id
    port = 80
}

resource "aws_alb_target_group_attachment" "attach2" {
    target_group_arn = aws_lb_target_group.test.arn
    target_id = aws_instance.main2.id
    port = 80
}





