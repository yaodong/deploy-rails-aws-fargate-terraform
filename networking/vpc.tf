# Create a VPC with CIDR block "10.0.0.0/16"
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name        = "${title(var.product)} VPC - ${title(var.env)}"
    Product     = var.product
    Environment = var.env
  }
}

# Internet Gateway (IGW) allows instances with public IPs to access the internet.
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Product     = var.product
    Environment = var.env
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

# NAT Gateway (NGW) allows instances with no public IPs to access the internet.
# A NAT Gateway must be in a public subnet and it requires a public IP.
resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Product     = var.product
    Environment = var.env
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = {
    Product     = var.product
    Environment = var.env
  }
}

resource "aws_route" "private" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this.id
}

# Public Subnets
resource "aws_subnet" "public" {
  count = length(var.vpc_zones)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.vpc_public_subnet_cidr_blocks[count.index]
  availability_zone_id    = var.vpc_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.product}-public-${count.index} - ${var.env}"
    Product     = var.product
    Environment = var.env
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.vpc_zones)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Private Subnets
resource "aws_subnet" "private" {
  count = length(var.vpc_zones)

  vpc_id               = aws_vpc.this.id
  cidr_block           = var.vpc_private_subnet_cidr_blocks[count.index]
  availability_zone_id = var.vpc_zones[count.index]

  tags = {
    Name    = "${var.product}-private-${count.index} - ${var.env}"
    Product = var.product
    Env     = var.env
  }
}

resource "aws_route_table_association" "private" {
  count = length(var.vpc_zones)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
