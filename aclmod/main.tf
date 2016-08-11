resource "aws_network_acl" "private_app_subnets" {
  vpc_id = "${var.vpc_id}"

  subnet_ids = ["${split(",", var.private_subnet_ids)}"]

  # Here, we ensure no ACLs are created until all the Gateways are ready

  #depends_on = ["null_resource.vpc_ready"]
}
