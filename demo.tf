module "vpc" {
  source = "./vpcmod"

  name = "module-repro-thing"

  cidr = "10.0.0.0/16"
}

module "acl" {
  source = "./aclmod"
  vpc_id = "${module.vpc.vpc_id}"
}
