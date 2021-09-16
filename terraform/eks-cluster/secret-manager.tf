resource "aws_secretsmanager_secret" "cluster_secrets" {
    name = "${local.global_prefix}_properties"
    recovery_window_in_days = 0
}


resource "aws_secretsmanager_secret_version" "environment_configuration" {
    secret_id = aws_secretsmanager_secret.cluster_secrets.id
    secret_string = jsonencode({
        REDIS_HOST = aws_elasticache_cluster.segmentme-redis.cache_nodes.0.address
        REDIS_PORT = aws_elasticache_cluster.segmentme-redis.cache_nodes.0.port
        API_LB_TG = aws_lb_target_group.lb-api-tg.arn
        WEB_LB_TG = aws_lb_target_group.lb-web-tg.arn
    }
    )
}
