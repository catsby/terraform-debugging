module "vpc" {
  source = "./vpcmod"

  name = "module-repro-thing"

  cidr            = "10.0.0.0/16"
  private_subnets = "10.0.1.0/24,10.0.2.0/24,10.0.3.0/24"
  public_subnets  = "10.0.101.0/24,10.0.102.0/24,10.0.103.0/24"

  azs = "us-west-2a,us-west-2b,us-west-2c"
}

module "acl" {
  source             = "./aclmod"
  vpc_id             = "${module.vpc.vpc_id}"
  private_subnet_ids = "${module.vpc.private_subnet_ids}"
}

output "thing" {
  value = "${module.vpc.private_subnet_ids}"
}
