resource "aws_secretsmanager_secret" "secret_values" {
    name = "${local.global_prefix}_properties"
}


resource "aws_secretsmanager_secret_version" "environment_configuration" {
    secret_id = aws_secretsmanager_secret.secret_values.id
    secret_string = jsonencode({
        REDIS_HOST = aws_elasticache_cluster.segmentme-redis.cache_nodes.0.address
        REDIS_PORT = aws_elasticache_cluster.segmentme-redis.cache_nodes.0.port
    }
    )
}
