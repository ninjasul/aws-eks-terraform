resource "aws_security_group" "test-sg-eks-cluster" {
  name        = "test-sg-eks-cluster"
  description = "security_group for test-eks-cluster"
  # AWS Console에서 확인 가능
  vpc_id      = "vpc-0f9fd3ecac1c6a523"

  tags = {
    Name = "test-sg-eks-cluster"
  }
}

# AWS Security Group의 Rule은 모든 통신이 기본적으로 deny 처리되어 있으며 allow 할 항목들만 아래에 명시하는 형태임.
resource "aws_security_group_rule" "test-sg-eks-cluster-ingress" {
  # 모든 inbound 요청을 허용하는 rule임.
  security_group_id = aws_security_group.test-sg-eks-cluster.id
  type              = "ingress"
  description       = "ingress security_group_rule for test-eks-cluster"
  from_port         = 0
  to_port           = 0
  # protocol = "-1" 은 모든 프로토콜을 가리킴.
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "test-sg-eks-cluster-egress" {
  # 모든 outbound 요청을 허용하는 rule임.
  security_group_id = aws_security_group.test-sg-eks-cluster.id
  type              = "egress"
  description       = "egress security_group_rule for test-eks-cluster"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}
