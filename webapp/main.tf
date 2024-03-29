data "aws_vpc" "default" {
  default = true
} 

data "aws_subnet_ids" "public" {
  vpc_id = "${data.aws_vpc.default.id}"
}

output "subnet_cidr_blocks" {
  value = data.aws_subnet_ids.public
}

# EKS Cluster
resource "aws_eks_cluster" "eks-cluster" {
  name     = "trdl-synch-cluster"
  role_arn = aws_iam_role.EKSClusterRole.arn
  version  = "1.21"

  vpc_config {
    subnet_ids          =  flatten( data.aws_subnet_ids.public.ids )
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy
  ]
}

# NODE GROUP
resource "aws_eks_node_group" "node-ec2" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "t3_small-trdl-synch-group"
  node_role_arn   = aws_iam_role.NodeGroupRole.arn
  subnet_ids      = flatten( data.aws_subnet_ids.public.ids )

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  ami_type       = "AL2_x86_64"
  instance_types = ["t3.small"]
  capacity_type  = "ON_DEMAND"
  disk_size      = 10

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy
  ]
  
  update_config {
    max_unavailable = 1
  }
}