# A VPC e as subnets são criadas pelo fiap-garageflow-k8s-infra; o RDS precisa ficar na mesma VPC do EKS.
data "aws_vpc" "garage_flow" {
  tags = {
    Name = var.vpc_name
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.garage_flow.id]
  }

  tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
}
