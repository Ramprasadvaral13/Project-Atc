resource "aws_eks_cluster" "k8s_cluster" {
  name     = "k8s-cluster"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = aws_subnet.public[*].id
    security_group_ids = [aws_security_group.k8s_sg.id]
  }
}
