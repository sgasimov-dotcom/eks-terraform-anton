resource "aws_iam_role" "demo" {
  #The name of the role 
  name = "eks-cluster-demo"
# The policy that grants an entity permission to assume the role.
# Used to access AWS resources that you might not normally have access to.
# The role that Amazon EKS use to create AWS resources for Kubernetes clusters.
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}
resource "aws_iam_role_policy_attachment" "demo-AmazonEKSClusterPolicy" {
  # The ARN of the policty you want to apply
  # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKSClusterPolicy
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.demo.name
}

resource "aws_eks_cluster" "eks" {
  name = "eks"
  # The Amazon Resource Name (ARN) of the IAM role that provides permissions for k8s control plane to
  # make calls to AWS API operations on your behalf
  role_arn = aws_iam_role.aws_eks_cluster.arn
  # Desired Kubernetes master version
  version = "1.18"
  vpc_config {
    # Indicates whether or not the Amazon EKS private API server endpoint is enabled
    # you may need this for vpn or bastion host setup 
    endpoint_private_access = false
    # Indicates whether or not the Amazon EKS public API server endpoint is enabled 
    endpoint_public_access = true
    # Must be in at least 2 diff AZ
    subnet_ids = [
      aws_subnet.public_1.id,
      aws_subnet.public_2.id,
      aws_subnet.private_1.id,
      aws_subnet.private_2.id
    ]
  }


# Ensure that IAM Role permissions are created before and deleted after EKS Cluster
# otherwise, eks won't be able to properly delete EKS managed ec2 infrastr

depends_on = [
  aws_iam_role_policy_attachment.amazon_eks_cluster_policy
]
}
# iam role 
resource "aws_eks_cluster" "demo" {
  name     = "demo"
  role_arn = aws_iam_role.demo.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.private-us-east-1a.id,
      aws_subnet.private-us-east-1b.id,
      aws_subnet.public-us-east-1a.id,
      aws_subnet.public-us-east-1b.id
    ]
  }
   # until this policy is ready cluster won't be created
  depends_on = [aws_iam_role_policy_attachment.demo-AmazonEKSClusterPolicy]
}

#OUTPUTS

output "aws_eks_cluster_name" {
  value = aws_eks_cluster.demo.id
}

output "aws_eks_cluster_arn" {
  value = aws_iam_role.demo.arn
}
