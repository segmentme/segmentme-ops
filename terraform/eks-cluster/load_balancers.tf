resource "aws_lb" "alb" {
    name = "${local.global_prefix}-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [
        aws_security_group.lb-sg.id]
    subnets = module.vpc.public_subnets

    tags = merge(local.default_tags, {
        "ingress.k8s.aws/resource" = "LoadBalancer"
        "ingress.k8s.aws/stack" = "default/web-app-ingress"
        "elbv2.k8s.aws/cluster" = local.cluster_name
    })
}

resource "aws_lb_target_group" "lb-web-tg" {
    name = "${local.global_prefix}-alb-web-tg"
    port = 31444
    protocol = "HTTP"
    target_type = "ip"
    vpc_id = module.vpc.vpc_id
    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 2
        interval = 5
        timeout = 3
    }
    tags = merge(local.default_tags, {
        "elbv2.k8s.aws/cluster" = local.cluster_name
    })

}


resource "aws_lb_target_group" "lb-api-tg" {
    name = "${local.global_prefix}-alb-api-tg"
    port = 31445
    protocol = "HTTP"
    target_type = "ip"
    vpc_id = module.vpc.vpc_id
    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 2
        interval = 5
        timeout = 3
    }
    tags = merge(local.default_tags, {
        "elbv2.k8s.aws/cluster" = local.cluster_name
    })

}

resource "aws_lb_listener" "http_listener" {
    load_balancer_arn = aws_lb.alb.arn
    port = "80"
    protocol = "HTTP"
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.lb-web-tg.arn
    }
}


resource "aws_lb_listener" "https_listener" {
    load_balancer_arn = aws_lb.alb.arn
    port = "443"
    protocol = "HTTPS"
    ssl_policy = "ELBSecurityPolicy-2016-08"
    certificate_arn = var.tls_certificate_arn

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.lb-web-tg.arn
    }
}


resource "aws_lb_listener_rule" "lb_https_api_rule" {
    listener_arn = aws_lb_listener.https_listener.arn
    priority = 99

    action {
        type = "forward"
        target_group_arn = aws_lb_target_group.lb-api-tg.arn
    }

    condition {
        host_header {
            values = [
                "api.${var.route_53_hosted_zone}"]
        }
    }
}


resource "aws_lb_listener_rule" "lb_http_api_rule" {
    listener_arn = aws_lb_listener.http_listener.arn
    priority = 99

    action {
        type = "forward"
        target_group_arn = aws_lb_target_group.lb-api-tg.arn
    }

    condition {
        host_header {
            values = [
                "api.${var.route_53_hosted_zone}"]
        }
    }
}