# VPC 생성
resource "aws_vpc" "simple_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "simple_vpc"
  }
}

# Subnet 생성(pub-1, pub-2, pri-1, pri-2)
resource "aws_subnet" "public_subnet1" {
  vpc_id = aws_vpc.simple_vpc.id
  cidr_block = "10.0.0.0/24"
  
  availability_zone = "ap-northeast-2a"
  
  tags = {
    Name = "public_subnet1"
  }
}

resource "aws_subnet" "public_subnet1" {
  vpc_id = aws_vpc.simple_vpc.id
  cidr_block = "10.0.1.0/24"
  
  availability_zone = "ap-northeast-2b"
  
  tags = {
    Name = "public_subnet2"
  }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id = aws_vpc.simple_vpc.id
  cidr_block = "10.0.2.0/24"
  
  availability_zone = "ap-northeast-2a"
  
  tags = {
    Name = "private_subnet2"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id = aws_vpc.simple_vpc.id
  cidr_block = "10.0.3.0/24"
  
  availability_zone = "ap-northeast-2a"
  
  tags = {
    Name = "private_subnet2"
  }
}

# igw 생성

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.simple_vpc.id
  tags = {
    Name = "simple_vpc_IGW"
  }
}
