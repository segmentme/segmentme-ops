resource "aws_elasticache_subnet_group" "segmentme-demo-redis-subnet" {
    name = local.redis_cluster_name
    subnet_ids = module.vpc.private_subnets

    tags = {
        Environment = var.environment
        GithubRepo = "segmentme-ops"
        GithubOrg = "segmentme"
    }
}


resource "aws_elasticache_cluster" "segmentme-redis" {
    cluster_id = local.redis_cluster_name
    engine = "redis"
    node_type = "cache.t3.small"
    num_cache_nodes = 1
    parameter_group_name = "default.redis6.x"
    engine_version = "6.x"
    security_group_ids = [
        aws_security_group.all_worker_mgmt.id]
    subnet_group_name = aws_elasticache_subnet_group.segmentme-demo-redis-subnet.name
    port = 6379

    tags = {
        Environment = var.environment
        GithubRepo = "segmentme-ops"
        GithubOrg = "segmentme"
    }
}
