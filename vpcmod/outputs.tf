output "vpc_id" {
  value = "${aws_vpc.mod.id}"
}

output "private_subnet_ids" {
  value = ["${aws_subnet.private.*.id})"]
}
