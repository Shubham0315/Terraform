module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name = "my_eks_cluster"
  cluster_version = "1.30"
  vpc_id = aws_vpc.main.id
  subnet_ids = aws_subnet.private[*].id

  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.medium"]
      min_size = 1
      max_size = 3
      desired_size = 2
    }
  }

  tags = {
    Environment = "dev"
    Team = "platform"
  }
}
