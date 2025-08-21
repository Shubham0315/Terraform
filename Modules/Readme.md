# Terraform Modules

- Terraform has providers like AWS, Azure, GCP which come with resources and data sources
- For reusable modules we can either write owwn collections of .tf files or use terraform registry modules

- Terraform modules are generally custom written
- Terraform registry/documentation provides thousands of ready to use modules like
  - terraform-aws-vpc
  - terraform-aws-eks
  - terraform-azure-vnet
  - terraform-google-gke
 
AWS Official Modules
-
- terraform-aws-modules/vpc/aws :- creates VPCs, subnets, route tables, gateways
- terraform-aws-modules/eks/aws :- deploys EKS clusters
- terraform-aws-modules/ec2-instance/aws :- launches EC2 with SG and networking
- terraform-aws-modules/security-groups/aws :- creates SG and rules
- terraform-aws-modules/iam/aws :- manages IAM roles, policies and users
- terraform-aws-modules/s3-bucket/aws :- creates and configures S3 buckets
- terraform-aws-modules/rds/aws :- provisions RDS databases
- terraform-aws-modules/lambda/aws :- manages AWS lambda functions

- These modules are prod-ready, tested and reusable so instead of writing dozens of resource blocks, we can consume them directly with just few lines of code

------------------------------------------------------------------------------------

VPC Module
-
- It simplifies creating and managing VPCs and all related networking resources in AWS like subnets, route tables, NAT gateways with minimal code

<img width="1548" height="720" alt="image" src="https://github.com/user-attachments/assets/eb037552-14f0-4766-9a06-9c1af90ee05a" />

- Using above code, the module will
  - Create VPC named "shubham-vpc", create 3 public subnets and 3 private subnets
  - Deploy single NAT gateway for outbound internet access
  - Auto configure route tables and routes
  - Tag all resources consistently
 
- Useful parameters
  - cidr :- CIDR block for VPC
  - azs :- az to spread subnets across
  - public_subnets :- list of public subnet cidr's
  - private_subnets :- list of private subnet cidr's
  - enable_nat_gateway :- whether to deploy NAT gateways (true/false)
  - single_nat_gateway :- use one NAT GW for cost savings
  - enable_dns_hostnames :- enable DNS hostnames inside VPC
 
- This module exports useful attributes which we can reuse in other modules like vpc_id, public_subnets, private_subnets, igw_id
