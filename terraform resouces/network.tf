resource "aws_vpc" "vpc55" {
 cidr_block = var.cidr
tags = {
        name = "vpc55"
  }
}
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "publicsubnets" {
    count = 2
    vpc_id = aws_vpc.vpc55.id
    cidr_block = element(var.subnetcidr,count.index)
    availability_zone = data.aws_availability_zones.available.names[count.index]

    tags = {
    Name = "subnet[count.index]"
  }
  depends_on = [
            aws_vpc.vpc55
  ]
}

resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.vpc55.id

  tags = {
    Name = "igw1"
  }
}

resource "aws_route_table" "myroute1" {
  vpc_id = aws_vpc.vpc55.id

      tags = {
    Name = "myroute1"
  }
}

resource "aws_route_table_association" "a" {
  count = length(var.subnetcidr)
  subnet_id      = element(aws_subnet.publicsubnets.*.id,count.index)
  route_table_id = aws_route_table.myroute1.id
}

resource "aws_route" "r" {
  route_table_id            = aws_route_table.myroute1.id
  gateway_id                = aws_internet_gateway.igw1.id
  destination_cidr_block    = "0.0.0.0/0"
}