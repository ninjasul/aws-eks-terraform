resource "aws_eks_cluster" "test-eks-cluster" {

  depends_on = [
    aws_iam_role_policy_attachment.test-iam-policy-eks-cluster,
    aws_iam_role_policy_attachment.test-iam-policy-eks-cluster-vpc,
  ]

  # cluster-name 이라는 변수명에 aws_eks_cluster resource의 name을 저장 해 놓음.
  # https://github.com/ninjasul/fastcampus-kubernetes-msa/blob/main/Part4_Kubernetes/Chapter02/Ch02_05-terraform-eks/terraform-codes/variables.tf 에 정의 되어 있음.
  name     = var.cluster-name

  # eks cluster가 가져야 하는 role의 arn을 명시
  role_arn = aws_iam_role.test-iam-role-eks-cluster.arn

  # eks cluster의 버전
  version = "1.28"

  # aws cloud watch 에서 볼 수 있는 EKS Controlplane 로그 항목들
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  # subnet_ids 는 AWS Console에서 확인 가능
  # "endpoint_public_access = true": 인터넷 망으로 EKS Cluster에 접근이 가능함.
  vpc_config {
    security_group_ids = [aws_security_group.test-sg-eks-cluster.id]
    subnet_ids         = ["subnet-02722c0a1586e5d9c","subnet-057ad44efd0875522"]
    endpoint_public_access = true
  }
}
