variable "cidr1_vpc" {
    description = "CIDR block vpc"
    default = "10.0.0.0/16"
}

variable "cidr1_subnet" {
    description = "CIDR block subnet 1 public"
    default = "10.0.0.0/24"
}

variable "cidr2_vpc" {
    description = "CIDR block vpc 2"
    default = "10.1.0.0/16"
}


variable "cidr1_subnet" {
    description = "CIDR block subnet 2 public"
    default = "10.1.0.0/24"
}

variable "availability_zone" {
    description = "AZ"
    default = "us-east-2a"
}

variable "instance_type" {
    description = "Instance Type of servers"
    default = "t2.micro"
}