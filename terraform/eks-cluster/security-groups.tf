resource "aws_security_group" "eks-cluster-sg" {
    name = "${local.global_prefix}_eks_sg"
    description = "EKS Cluster security group"
    vpc_id = module.vpc.vpc_id
    tags = merge(local.default_tags, {
        "Name" = "${local.global_prefix}_eks-cluster-sg"
    })

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [
            "0.0.0.0/0"]
    }

}


resource "aws_security_group" "redis-sg" {
    name = "${local.global_prefix}_redis-sg"
    description = "Redis Cluster security group"
    vpc_id = module.vpc.vpc_id
    tags = merge(local.default_tags, {
        "Name" = "${local.global_prefix}_redis-sg"
    })


    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        description = "Allow traffic from eks worker nodes"
        security_groups = [
            aws_security_group.eks-cluster-worker-sg.id]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [
            "0.0.0.0/0"]
    }
}

resource "aws_security_group" "eks-cluster-worker-sg" {
    name = "${local.global_prefix}_eks-wg-sg"
    description = "EKS worker nodes security group"
    vpc_id = module.vpc.vpc_id
    tags = merge(local.default_tags, {
        "Name" = "${local.global_prefix}_eks-wg-sg"
    })


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
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        description = "Allow traffic from load balancer"
        security_groups = [
            aws_security_group.lb-sg.id]
    }

    ingress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        description = "Allow workers pods to receive communication from the cluster control plane."
        security_groups = [
            aws_security_group.eks-cluster-sg.id]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        description = "Allow pods running extension API servers on port 443 to receive communication from cluster control plane."
        security_groups = [
            aws_security_group.eks-cluster-sg.id]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [
            "0.0.0.0/0"]
    }
}

resource "aws_security_group" "lb-sg" {
    name = "${local.global_prefix}_lb-sg"
    description = "Load balancer security group"
    vpc_id = module.vpc.vpc_id
    tags = merge(local.default_tags, {
        "Name" = "${local.global_prefix}_lb-sg"
        "Description" = "Load balancer security group"
    })

    ingress {
        description = "Accept traffic from internet"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [
            "0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [
            "0.0.0.0/0"]
    }
}


resource "aws_security_group_rule" "wg-self-sg-rule" {
    type = "ingress"
    description = "Allow node to communicate with each other."
    from_port = 0
    to_port = 65535
    protocol = "-1"
    security_group_id = aws_security_group.eks-cluster-worker-sg.id
    source_security_group_id = aws_security_group.eks-cluster-worker-sg.id
}

resource "aws_security_group_rule" "wg-redis-sg-rule" {
    type = "ingress"
    description = "Allow traffic from needed for Redis"
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_group_id = aws_security_group.eks-cluster-worker-sg.id
    source_security_group_id = aws_security_group.redis-sg.id
}


resource "aws_security_group_rule" "cluster_https_worker_ingress" {
    description = "Allow pods to communicate with the EKS cluster API."
    protocol = "tcp"
    security_group_id = aws_security_group.eks-cluster-sg.id
    source_security_group_id = aws_security_group.eks-cluster-worker-sg.id
    from_port = 443
    to_port = 443
    type = "ingress"
}
