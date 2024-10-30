terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Set up AWS provider
provider "aws" {
  region = "us-east-2"
}

# Create a VPC
resource "aws_vpc" "tf_vpc_02" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Terraform VPC"
    Mode = "IaC"
  } 
}

# Create two subnets within the VPC
resource "aws_subnet" "tf_public_subnet_02" {
  vpc_id = aws_vpc.tf_vpc_02
  cidr_block = "10.0.0.0/24"
}

resource "aws_subnet" "tf_private_subnet_02" {
  vpc_id = aws_vpc.tf_vpc_02
  cidr_block = "10.0.1.0/24"
}

# Create an Internet gateway and attach it to the VPC
resource "aws_internet_gateway" "tf_igw_02" {
 vpc_id =  aws_vpc.tf_vpc_02
}


# Create a route table for the public subnet. This table will direct all traffic to the igw
resource "aws_route_table" "tf_public_rtb_02" {
  vpc_id = aws_vpc.tf_vpc_02

  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_igw_02.id
  }
}

# Associate the route table with the public subnet
resource "aws_route_table_association" "tf_public_subnet_02" {
  subnet_id = aws_subnet.tf_public_subnet_02.id
  route_table_id = aws_route_table.tf_public_rtb_02
}