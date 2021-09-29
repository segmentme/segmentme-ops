module "eks" {
    source = "terraform-aws-modules/eks/aws"
    cluster_version = "1.21"

    cluster_create_security_group = false
    worker_create_security_group = false
    enable_irsa = true

    cluster_name = local.cluster_name
    subnets = module.vpc.private_subnets

    cluster_security_group_id = aws_security_group.eks-cluster-sg.id
    worker_security_group_id = aws_security_group.eks-cluster-worker-sg.id

    tags = local.default_tags

    vpc_id = module.vpc.vpc_id

    workers_additional_policies = [
        aws_iam_policy.load-balancer-policy.arn]

    node_groups_defaults = {
        instance_types = []
    }
    node_groups = {
        group1 = {
            desired_capacity = 1
            max_capacity = 5
            min_capacity = 1
            launch_template_id = aws_launch_template.eks-node-template.id
            launch_template_version = aws_launch_template.eks-node-template.default_version
            tags = [
                {
                    "key" = "k8s.io/cluster-autoscaler/enabled"
                    "propagate_at_launch" = "false"
                    "value" = "true"
                },
                {
                    "key" = "k8s.io/cluster-autoscaler/${local.cluster_name}"
                    "propagate_at_launch" = "false"
                    "value" = "owned"
                }
            ]

            additional_tags = {
                CustomTag = "EKS node group"

            }
        }
    }
}


resource "aws_iam_policy" "load-balancer-policy" {
    name = "AWSLoadBalancerControllerIAMPolicy"
    path = "/"
    description = "AWS LoadBalancer Controller IAM Policy"

    policy = file("iam-policy.json")
    tags = local.default_tags
}


resource "helm_release" "application-load-balancer-controller" {
    depends_on = [
        aws_security_group_rule.wg-self-sg-rule,
        aws_security_group_rule.cluster_https_worker_ingress]
    name = "alb"
    chart = "aws-load-balancer-controller"
    repository = "https://aws.github.io/eks-charts"
    version = "1.2.6"
    set {
        name = "clusterName"
        value = local.cluster_name
    }
    set {
        name = "vpcId"
        value = module.vpc.vpc_id
    }

    set {
        name = "region"
        value = var.region
    }

    //    set {
    //        name = "serviceAccount.name"
    //        value = "aws-load-balancer-controller"
    //    }

}

resource "helm_release" "eks-autoscaler" {
    depends_on = [
        helm_release.application-load-balancer-controller
    ]
    name = "eks-autoscaler"
    chart = "cluster-autoscaler"
    repository = "https://kubernetes.github.io/autoscaler"
    version = "9.10.7"
    set {
        name = "rbac.serviceAccount.annotations\\.eks.amazonaws.com/role-arn"
        value = "arn:aws:iam::${local.accountNumber}::role/cluster-autoscaler"
    }

    set {
        name = "autoDiscovery.clusterName"
        value = local.cluster_name
    }

    set {
        name = "awsRegion"
        value = var.region
    }

}


//resource "null_resource" "post-policy" {
//  depends_on = [
//  aws_iam_policy.load-balancer-policy]
//  triggers = {
//    always_run = timestamp()
//  }
//  provisioner "local-exec" {
//    on_failure = fail
//    interpreter = [
//      "/bin/bash",
//    "-c"]
//    when    = create
//    command = <<EOT
//        reg=$(echo ${data.aws_eks_cluster.cluster.arn} | cut -f4 -d':')
//        acc=$(echo ${data.aws_eks_cluster.cluster.arn} | cut -f5 -d':')
//        cn=$(echo ${data.aws_eks_cluster.cluster.name})
//        echo "$reg $cn $acc"
//        ./albc.sh $reg $cn $acc
//        echo "done"
//     EOT
//  }
//}

data "aws_eks_cluster" "cluster" {
    name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
    name = module.eks.cluster_id
}

data "aws_caller_identity" "current" {}