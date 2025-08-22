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

------------------------------------------------------------------------------------

EC2 Module
-
- It makes easier to launch and manage EC2 instances with various options like key-pairs, volumes, SGs

<img width="1511" height="702" alt="image" src="https://github.com/user-attachments/assets/7a4d08fb-bdaa-4a6c-830a-85453853b9b6" />

- Useful parameters
  - ami :- AMI ID of instance
  - instance_type :- EC2 type
  - key_name :- SSH key pair name
  - subnet_id
  - vpc_security_groups_id :- List of SGs
  - user_data :- Pass bootstrap scripts
 
- Outputs
  - id :- EC2 instance ID
  - arn :- EC2 instance ARN
  - public_ip :- Public IP address
  - private_ip :- private IP address

------------------------------------------------------------------------------------

S3 Module
-
- This module auto manages S3 creation, versioning, encryption , logging, bucket policies
- We can also add code to host static website. Block public access as shown below
- It makes easier to create prod ready buckets without manually writing dozens of resources

<img width="1910" height="866" alt="image" src="https://github.com/user-attachments/assets/dfdefbbe-50d4-4623-af60-a7323365d8b2" />

------------------------------------------------------------------------------------

Lambda Module
- 
- Lambda module simplifies deployment

<img width="1600" height="756" alt="image" src="https://github.com/user-attachments/assets/371f6994-6e58-4719-96dc-26571a2451e9" />

- Use cases of lambda module
  - Event driven functions
  - Microservices deployments
  - Automation scripts
  - Infrastructure hooks
 
- Lambda saves from manually writing things and add triggers

------------------------------------------------------------------------------------

EKS Module
-
- This module is popular to manage EKS.
- This creates EKS control plane, managed node group, IAM roles and policies, security groups


<img width="1847" height="773" alt="image" src="https://github.com/user-attachments/assets/cda6edd6-a9f7-49cf-a7a4-498021e3b51f" />

- We can also add fargate profile code in this module which is useful for serverless K8S pods

- Use cases of EKS Module
  - Standard EKS cluster with managed worker nodes
  - Cost optimized serverless EKS using fargate profiles
  - Prod ready clusters with IAM roles, logging
  - Multi team setup for separate namespaces, RBAC and node groups
