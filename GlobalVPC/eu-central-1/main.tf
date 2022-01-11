provider "aws" {
  alias ="region"
}

resource "aws_cloudformation_stack" "demo-vpc" {
  name = "eu-central-1"
  template_body = "${file("./us-east-2/demo-vpc-eu-central-1.yaml")}"
  provider = "aws.region"
}