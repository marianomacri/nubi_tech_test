variable "region" {
  description = "Region on which the resources will be deployed"
  type        = string
}

variable "access_key" {
  description = "AWS Access Key"
  type        = string
}

variable "secret_key" {
  description = "AWS Secret Key"
  type        = string
}

variable "vpc_id" {
  description = "VPC on which the resources will be deployed. Format: vpc-*"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of Public Subnets on which the ALB will be deployed. Format: ['subnet-*','subnet-*']"
  type        = list(string)
}

variable "private_subnet_id" {
  description = "Private Subnet on which the webservers will be deployed. Format: 'subnet-*'"
  type        = string
}

variable "nginx_details" {
  description = "Details for the nginx webserver instance deployment"
  type = object(
    {
      name                 = string,
      instance_type        = string,
      instance_volume_size = string
  })
  default = {
    name                 = "nginx-webserver",
    instance_type        = "t2.micro",
    instance_volume_size = "50"
  }

}

variable "apache_details" {
  description = "Details for the apache webserver instance deployment"
  type = object(
    {
      name                 = string,
      instance_type        = string,
      instance_volume_size = string
  })
  default = {
    name                 = "apache-webserver",
    instance_type        = "t2.micro",
    instance_volume_size = "50"
  }

}

