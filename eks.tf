resource "aws_eks_cluster" "example" {
  name                      = var.cluster_name
  version                   = var.eks_version
  enabled_cluster_log_types = ["api", "authenticator", "controllerManager", "scheduler"]
  role_arn                  = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids              = [aws_subnet.public_1.id, aws_subnet.public_2.id, aws_subnet.private_1.id, aws_subnet.private_2.id]
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  access_config {
    authentication_mode                         = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks_cluster-AmazonEKSVPCResourceController,
  ]
}

resource "aws_eks_addon" "core-dns" {
  cluster_name  = aws_eks_cluster.example.name
  addon_name    = "coredns"
  addon_version = "v1.11.1-eksbuild.4" #e.g., previous version v1.9.3-eksbuild.3 and the new version is v1.10.1-eksbuild.1
  depends_on = [
    aws_eks_node_group.node_group
  ]
}

resource "aws_eks_addon" "vpc-cni" {
  cluster_name  = aws_eks_cluster.example.name
  addon_name    = "vpc-cni"
  addon_version = "v1.18.1-eksbuild.3" #e.g., previous version v1.9.3-eksbuild.3 and the new version is v1.10.1-eksbuild.1
}

resource "aws_eks_addon" "kube-proxy" {
  cluster_name  = aws_eks_cluster.example.name
  addon_name    = "kube-proxy"
  addon_version = "v1.29.7-eksbuild.9" #e.g., previous version v1.9.3-eksbuild.3 and the new version is v1.10.1-eksbuild.1
}

resource "aws_eks_addon" "eks-pod-identity-agent" {
  cluster_name  = aws_eks_cluster.example.name
  addon_name    = "eks-pod-identity-agent"
  addon_version = "v1.3.2-eksbuild.2" #e.g., previous version v1.9.3-eksbuild.3 and the new version is v1.10.1-eksbuild.1
}

output "endpoint" {
  value = aws_eks_cluster.example.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.example.certificate_authority[0].data
}
