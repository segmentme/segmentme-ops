resource "aws_security_group" "worker_group_mgmt_one" {
    name_prefix = "${local.global_prefix}_wg_sg_one"
    vpc_id = module.vpc.vpc_id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"

        cidr_blocks = [
            "10.0.0.0/8",
        ]
    }
}

resource "aws_security_group" "worker_group_mgmt_two" {
    name_prefix = "${local.global_prefix}_wg_sg_two"
    vpc_id = module.vpc.vpc_id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"

        cidr_blocks = [
            "192.168.0.0/16",
        ]
    }

}

resource "aws_security_group" "all_worker_mgmt" {
    name_prefix = "${local.global_prefix}_all_wg_sg"
    vpc_id = module.vpc.vpc_id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"

        cidr_blocks = [
            "10.0.0.0/8",
            "172.16.0.0/12",
            "192.168.0.0/16",
        ]
    }

    ingress {
        from_port = 6379
        to_port = 6379
        protocol = "tcp"

        cidr_blocks = [
            module.vpc.vpc_cidr_block]
    }
}
