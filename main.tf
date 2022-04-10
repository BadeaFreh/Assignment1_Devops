# reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs

terraform {
  required_providers {
      aws = {
          source = "hashicorp/aws"
          version = "~> 3.0"
      }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "user7" {
    # meaning: 3 octets for network (24 ones)
    #          1 octet for the hosts
    # 192.168.7.0 is an example of one of these subnets
    # (it can contain ~(2^8) hosts in it)
    # we only need 20 ipv4 ip addresses in this assignment, this is more than enough
  cidr_block = "10.120.7.0/24"
}

# Web Subnet
resource "aws_subnet" "web_subnet" {
    vpc_id = aws_vpc.user7.id
  # (27 bits for the subnet, 5 bits for hosts)
  # in ordr to mak 20 availabl ip addrsss, w nd 2^5 bits
  cidr_block = "10.120.7.0/27"

}

# App Subnet
resource "aws_subnet" "app_subnet" {
  # why 32 bits on th last octt? first 32 ips (0-31) ar for wb subnt
  # th first mpty ip is x.x.x.32
  vpc_id = aws_vpc.user7.id
  cidr_block = "10.120.7.32/27"
}

# DB Subnet
resource "aws_subnet" "db_subnet" {
  vpc_id = aws_vpc.user7.id
  # 28 bits for th ntwork, 4 bits for th hosts
  cidr_block = "10.120.7.64/28"
}
