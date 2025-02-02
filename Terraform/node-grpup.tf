resource "aws_eks_node_group" "k8s_nodes" {
  cluster_name    = aws_eks_cluster.k8s_cluster.name
  node_group_name = "k8s-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = aws_subnet.public[*].id

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
}
