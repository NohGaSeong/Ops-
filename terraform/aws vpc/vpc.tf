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

# rtb 생성
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.simple_vpc.id
  
  tags = {
    Name = "public_rt"
  }
}

resource "aws_route_table_association" "public_rt_association_1" {
  subnet_id = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rt_association_2" {
  subnet_id = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_rt.id
}

# EIP 생성
resource "aws_eip" "nat_ip" {
  vpc = true
  
  lifecycle {
    cretae_before_destroy = true
  }
}

# NAT 게이트웨이
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_ip.id
  
  subnet_id = aws_subnet.public_subnet1.id
  
  tags = {
    Name = "public-nat"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.simple_vpc.id
  
  tags = {
    Name = "private_rt"
  }
}

# private rtb에 연결
resource "aws_route_table_association" "private_rt_association1" {
  subnet_id = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_rt_association2" {
  subnet_id = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route" "private_rt_nat" {
  route_table_id = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gateway.id
