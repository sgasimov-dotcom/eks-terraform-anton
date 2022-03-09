# Resource: aws_route_table
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table

resource "aws_route_table" "public" {
  # The VPC ID.
  vpc_id = aws_vpc.main.id

  route {
    # The CIDR block of the route.
    cidr_block = "0.0.0.0/0"

    # Identifier of a VPC internet gateway or a virtual private gateway.
    gateway_id = aws_internet_gateway.main.id
  }

  # A map of tags to assign to the resource.
  tags = {
    Name = "public"
  }
}

resource "aws_route_table" "private1" {
  # The VPC ID.
  vpc_id = aws_vpc.main.id

  route {
    # The CIDR block of the route.
    cidr_block = "0.0.0.0/0"

    # Identifier of a VPC NAT gateway.
    nat_gateway_id = aws_nat_gateway.gw1.id
  }

  # A map of tags to assign to the resource.
  tags = {
    Name = "private1"
  }
}

resource "aws_route_table" "private2" {
  # The VPC ID.
  vpc_id = aws_vpc.main.id

  route {
    # The CIDR block of the route.
    cidr_block = "0.0.0.0/0"

    # Identifier of a VPC NAT gateway.
    nat_gateway_id = aws_nat_gateway.gw2.id
  }

  # A map of tags to assign to the resource.
  tags = {
    Name = "private2"
  }
}

//another example of route table
// resource "aws_route_table" "private" {
//   vpc_id = aws_vpc.main.id

//   route = [
//     {
//       cidr_block                 = "0.0.0.0/0"
//       nat_gateway_id             = aws_nat_gateway.nat.id
//       carrier_gateway_id         = ""
//       destination_prefix_list_id = ""
//       egress_only_gateway_id     = ""
//       gateway_id                 = ""
//       instance_id                = ""
//       ipv6_cidr_block            = ""
//       local_gateway_id           = ""
//       network_interface_id       = ""
//       transit_gateway_id         = ""
//       vpc_endpoint_id            = ""
//       vpc_peering_connection_id  = ""
//     },
//   ]

//   tags = {
//     Name = "private"
//   }
// }