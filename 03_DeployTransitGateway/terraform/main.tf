provider "aws" {
    region = "us-east-2"
  
}

resource "aws_vpc" "vpc1" {
    cidr_block = "${var.cidr1_vpc}"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "vpc1"
    }
}

resource "aws_internet_gateway" "igw1" {
    vpc_id = aws_vpc.vpc1.id
    tags = {
        Name = "igw1"
    }
}

resource "aws_subnet" "subnet1_public" {
    vpc_id = aws_vpc.vpc1.id
    cidr_block = var.cidr1_subnet
    map_public_ip_on_launch = true
    availability_zone = var.availability_zone

    tags = {
        Name = "subnet1_public"
    }
  
}

resource "aws_route_table" "rtb1_public" {
    vpc_id = aws_vpc.vpc1.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw1.id
    }

    tags = {
      "Name" = "rt_public"
    }
  
}

resource "aws_route_table_association" "rta_subnet1_public" {
    subnet_id = aws_subnet.subnet1_public.id
    route_table_id = aws_route_table.rtb1_public.id  
}

resource "aws_security_group" "sg_public" {
  name        = "sg_public"
  description = "Security group for subnet"
  vpc_id      = aws_vpc.vpc1.id

  ingress {
    description      = "SSH to Server"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "sg_public"
  }
}

resource "aws_instance" "server1" {
    ami = data.aws_ami.amazonlinux2.id
    instance_type = var.instance_type
    subnet_id = var.cidr1_subnet.id
    vpc_security_group_ids = [aws_security_group.sg_public.id]
    key_name = "kgtoledoc"
    tags = {
        Name = "server1"
    }
}



resource "aws_vpc" "vpc2" {
    cidr_block = "${var.cidr2_vpc}"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "vpc2"
    }
}

resource "aws_internet_gateway" "igw2" {
    vpc_id = aws_vpc.vpc2.id
    tags = {
        Name = "igw2"
    }
}

resource "aws_subnet" "subnet2_public" {
    vpc_id = aws_vpc.vpc2.id
    cidr_block = var.cidr2_subnet
    map_public_ip_on_launch = true
    availability_zone = var.availability_zone

    tags = {
        Name = "subnet2_public"
    }
  
}

resource "aws_route_table" "rtb2_public" {
    vpc_id = aws_vpc.vpc2.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw2.id
    }

    tags = {
      "Name" = "rt_public"
    }
  
}

resource "aws_route_table_association" "rta_subnet2_public" {
    subnet_id = aws_subnet.subnet2_public.id
    route_table_id = aws_route_table.rtb2_public.id  
}

resource "aws_security_group" "sg2_public" {
  name        = "sg_public"
  description = "Security group for subnet"
  vpc_id      = aws_vpc.vpc2.id

  ingress {
    description      = "SSH to Server"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "sg_public"
  }
}

resource "aws_instance" "server2" {
    ami = data.aws_ami.amazonlinux2.id
    instance_type = var.instance_type
    subnet_id = var.cidr2_subnet.id
    vpc_security_group_ids = [aws_security_group.sg2_public.id]
    key_name = "kgtoledoc"
    tags = {
        Name = "server2"
    }
}
