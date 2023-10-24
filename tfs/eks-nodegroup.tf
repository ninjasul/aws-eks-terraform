resource "aws_eks_node_group" "test-eks-nodegroup" {
  # EKS Cluster 명
  cluster_name    = aws_eks_cluster.test-eks-cluster.name
  node_group_name = "test-eks-nodegroup"

  # 별도로 생성한 nodegroup 의 role arn
  node_role_arn   = aws_iam_role.test-iam-role-eks-nodegroup.arn

  # EKS Cluster와 동일한 subnet 사용
  subnet_ids      = ["subnet-02722c0a1586e5d9c","subnet-057ad44efd0875522"]
  instance_types = ["t3a.medium"]
  disk_size = 20

  labels = {
    "role" = "eks-nodegroup"
  }

  # desired_size: EKS 시작 시 생성되는 worker 노드 개수
  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }

  depends_on = [
    aws_iam_role_policy_attachment.test-iam-policy-eks-nodegroup,
    aws_iam_role_policy_attachment.test-iam-policy-eks-nodegroup-cni,
    aws_iam_role_policy_attachment.test-iam-policy-eks-nodegroup-ecr,
  ]

  tags = {
    "Name" = "${aws_eks_cluster.test-eks-cluster.name}-worker-node"
  }
}
