resource "aws_elasticache_cluster" "mscache" {
  cluster_id = "es"
  engine = "redis"
  engine_version = "${var.redis_config["engine_version"]}"
  node_type = "cache.${var.redis_config["instance_type"]}"
  port = 6379
  num_cache_nodes = 1
  #parameter_group_name = "${aws_elasticache_parameter_group.default.id}"
  parameter_group_name = "${lookup(var.redis_engines, var.redis_config["engine_version"])}"
  security_group_ids = ["${aws_security_group.cache_sg.id}"]
  subnet_group_name = "${aws_elasticache_subnet_group.cache.name}"
  az_mode = "single-az"
  availability_zone = "${element(split(",", var.vpc["availability_zones"]), 1)}"

}
resource "aws_security_group" "cache_sg" {

  name = "${var.name}-cache"
  description = "Cache ports"
  vpc_id = "${var.vpc["vpc_id"]}"

  // allow traffic for TCP 22 (SSH)
  ingress {
    from_port = 6379
    to_port = 6379
    protocol = "tcp"
    cidr_blocks = ["${split(",", var.vpc["vpc_cidr"])}"]
  }
  egress {
    from_port = 1024
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["${split(",", var.vpc["vpc_cidr"])}"]
  }
}
resource "aws_elasticache_subnet_group" "cache" {
    name = "cache-subnet"
    subnet_ids = ["${split(",", var.internal_subnets_id)}"]
}
//resource "aws_elasticache_parameter_group" "default" {
//  name = "defaultredis${var.deployment["id"]}"
//  family = "redis3.2"
//
//  parameter {
//      name = "activerehashing"
//      value = "yes"
//  }
//
//  parameter {
//      name = "min-slaves-to-write"
//      value = "2"
//  }
//  count = "1"
//}