region            = ""
access_key        = ""
secret_key        = ""
vpc_id            = "vpc-xxx"
public_subnet_ids = ["subnet-XXX", "subnet-XXX"]
private_subnet_id = "subnet-XXX"
nginx_details = {
  name                 = "nginx-webserver",
  instance_type        = "t2.micro",
  instance_volume_size = "50"
}
apache_details = {
  name                 = "apache-webserver",
  instance_type        = "t2.micro",
  instance_volume_size = "50"
}