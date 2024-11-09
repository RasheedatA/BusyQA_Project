data "aws_eks_cluster_auth" "eks" {
  name = aws_eks_cluster.example.name
}

provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.example.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.example.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}

resource "helm_release" "aws-ebs-csi-driver" {
  depends_on = [aws_eks_node_group.node_group]

  name       = "aws-ebs-csi-driver"
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver/"
  chart      = "aws-ebs-csi-driver"
  namespace  = "kube-system"
  version    = "2.35.1"
}

resource "helm_release" "metrics_server" {
  depends_on = [aws_eks_node_group.node_group]
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = "kube-system"
  version    = "3.12.1"
}

resource "helm_release" "cluster_autoscaler" {
  depends_on = [aws_eks_node_group.node_group]
  name       = "autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  namespace  = "kube-system"
  version    = "9.37.0"
}

resource "helm_release" "nginx-ingress" {
  depends_on       = [aws_eks_node_group.node_group]
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx/"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = "true"
  version          = "4.11.3"
}
