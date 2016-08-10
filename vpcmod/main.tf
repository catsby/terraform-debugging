resource "aws_vpc" "mod" {
  cidr_block = "${var.cidr}"

  tags {
    Name = "${var.name}"
  }
}

resource "aws_internet_gateway" "mod" {
  vpc_id = "${aws_vpc.mod.id}"
}
