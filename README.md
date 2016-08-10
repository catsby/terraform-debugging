vpc terraform module repro test for https://github.com/hashicorp/terraform/issues/7527
===========

A terraform module to demo/reproduce https://github.com/hashicorp/terraform/issues/7527

Usage
-----

This should "just work" with credentials setup either in the environment, or
modify insert a `provider "aws"` block in there:

- clone repo
- `$ teraform get`
- `$ terraform apply`


Viewing/Refreshing the Graph
------

The included `out.png` file was generated like so:

```
$ terraform plan -out create.tfplan
$ terraform graph create.tfplan | dot -Tpng > out.png
```

It assumes you have `dot` installed. 

Authors
=======

[Clint Shryock](https://github.com/phinze), borrowing heavily from https://github.com/terraform-community-modules/tf_aws_vpc
