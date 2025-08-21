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
