provider "aws" {
  alias = "region"
}

resource "aws_cloudformation_stack" "demo-vpc" {
  name = "ap-southeast-1"
  template_body = "${file("./us-east-2/demo-vpc-ap-southeast-1.yaml")}"
  provider = aws.region
}