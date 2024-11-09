resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.example.name
  node_group_name = "eks-node-group"
  node_role_arn   = aws_iam_role.node_group.arn
  subnet_ids      = [aws_subnet.private_1.id, aws_subnet.private_2.id]

  #  ami_type       = var.ami_type
  instance_types = var.instance_type

  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }

  remote_access {
    ec2_ssh_key = var.key_name
    #   source_security_groups = [aws_security_group.eks_node_group_sg.id]
  }
  #  security_group_ids = [aws_security_group.eks_node_group_sg.id]

  update_config {
    max_unavailable = var.min_size
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.

  depends_on = [
    aws_iam_role_policy_attachment.node_group-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_group-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_group-AmazonEC2ContainerRegistryReadOnly,
  ]
}
