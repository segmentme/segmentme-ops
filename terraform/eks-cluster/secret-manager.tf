resource "aws_secretsmanager_secret" "cluster_secrets" {
    name = "${local.global_prefix}_properties"
}


resource "aws_secretsmanager_secret_version" "environment_configuration" {
    secret_id = aws_secretsmanager_secret.cluster_secrets.id
    secret_string = jsonencode({
        REDIS_HOST = aws_elasticache_cluster.segmentme-redis.cache_nodes.0.address
        REDIS_PORT = aws_elasticache_cluster.segmentme-redis.cache_nodes.0.port
    }
    )
}
