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
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.demo.name
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
