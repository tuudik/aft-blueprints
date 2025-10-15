# Copyright Amazon.com, Inc. or its affiliates. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

module "tgw" {
  source = "../../../../common/modules/network/tgw"

  amazon_side_asn   = var.tgw_amazon_side_asn
  route_tables      = local.tgw_route_tables
  propagation_rules = local.tgw_propagation_rules
  region_name       = var.region_name
}

module "tgw_routing" {
  source = "../../../../common/modules/network/tgw_routing"

  routing_config = {
    shared = {
      tgw_route_table_id = module.tgw.route_table_id["shared"]
      routes = [
        {
          destination_cidr_blocks = ["0.0.0.0/0"]
          tgw_attachment_id       = module.vpc_inspection.tgw_attachment_id
        }
      ]
    }
    prod = {
      tgw_route_table_id = module.tgw.route_table_id["prod"]
      routes = [
        {
          destination_cidr_blocks = ["0.0.0.0/0"]
          tgw_attachment_id       = module.vpc_inspection.tgw_attachment_id
        }
      ]
    }
    stage = {
      tgw_route_table_id = module.tgw.route_table_id["stage"]
      routes = [
        {
          destination_cidr_blocks = ["0.0.0.0/0"]
          tgw_attachment_id       = module.vpc_inspection.tgw_attachment_id
        }
      ]
    }
    dev = {
      tgw_route_table_id = module.tgw.route_table_id["dev"]
      routes = [
        {
          destination_cidr_blocks = ["0.0.0.0/0"]
          tgw_attachment_id       = module.vpc_inspection.tgw_attachment_id
        }
      ]
    }
  }
}
