This repository helps you to deploy the following resources:

1 x Application Load Balancer
    - 1 x S3 bucket for Access Log to the ALB

2 x Security Groups
    - 1 x SG for the ALB allowing incomming HTTP traffic
    - 1 x SG for the instances allowing incomming HTTP traffic from the ALB

1 x Target Group pointing to the EC2 instances

2 x EC2 instances
    - 1 x EC2 instance with Apache ready
    - 1 x EC2 instance with NGINX ready

-----------------------------------------------------------------------------------

Expected Inputs:
    - region

    - access_key

    - secret_key

    - vpc_id

    - public_subnet_ids

    - private subnet id

    - nginx_details (optional, as is set by default)
    
    - apache_details (optional, as is set by default)

(you can just modify the vars.auto.tfvars)

-----------------------------------------------------------------------------------

Expected Output:
    - DNS Name of the ALB