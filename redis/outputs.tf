output "redis_endpoint_address" {
  value = "${aws_elasticache_cluster.mscache.cache_nodes}"
}
output "redis_endpoint_url" {
  value = "${aws_elasticache_cluster.mscache.configuration_endpoint}"
}