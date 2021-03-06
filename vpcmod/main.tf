resource "aws_vpc" "mod" {
  cidr_block = "${var.cidr}"

  tags {
    Name = "${var.name}"
  }
}

resource "aws_internet_gateway" "mod" {
  vpc_id = "${aws_vpc.mod.id}"
}

resource "aws_route_table" "public" {
  vpc_id           = "${aws_vpc.mod.id}"
  propagating_vgws = ["${compact(split(",", var.public_propagating_vgws))}"]

  tags {
    Name = "${var.name}-public"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.mod.id}"
}

resource "aws_route_table" "private" {
  vpc_id           = "${aws_vpc.mod.id}"
  propagating_vgws = ["${compact(split(",", var.private_propagating_vgws))}"]

  tags {
    Name = "${var.name}-private"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${element(split(",", var.private_subnets), count.index)}"
  availability_zone = "${element(split(",", var.azs), count.index)}"
  count             = "${length(compact(split(",", var.private_subnets)))}"

  tags {
    Name = "${var.name}-private"
  }
}

resource "aws_subnet" "public" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${element(split(",", var.public_subnets), count.index)}"
  availability_zone = "${element(split(",", var.azs), count.index)}"
  count             = "${length(compact(split(",", var.public_subnets)))}"

  tags {
    Name = "${var.name}-public"
  }

  map_public_ip_on_launch = true
}

resource "aws_route_table_association" "private" {
  count          = "${length(compact(split(",", var.private_subnets)))}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${aws_route_table.private.id}"
}

resource "aws_route_table_association" "public" {
  count          = "${length(compact(split(",", var.public_subnets)))}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}
