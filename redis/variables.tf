variable "name" { default = "eccentral" }
variable "internal_subnets_id" { default = "subnet-84af47df,subnet-eeee34a7,subnet-66bf554b" }

variable "vpc" {
  type = "map"
  default = {
    vpc_id = "vpc-54481033"
    vpc_cidr = "172.31.0.0/16"
    availability_zones = "us-east-1d,us-east-1c,us-east-1b"
  }
}

variable "redis_config" {
type = "map"
  default = {
    instance_type = "t2.small"
    engine_version = "2.8.6"
  }
}
variable "redis_engines" {
  type = "map"
  default = {
    "2.6.13" = "default.redis2.6"
    "2.8.23" = "default.redis2.8"
    "2.8.24" = "default.redis2.8"
    "2.8.22" = "default.redis2.8"
    "2.8.21" = "default.redis2.8"
    "2.8.19" = "default.redis2.8"
    "2.8.6" = "default.redis2.8"
    "3.2.4" = "default.redis3.2"
  }
}