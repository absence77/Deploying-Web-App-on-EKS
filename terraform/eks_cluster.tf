resource "aws_iam_role" "iam_eks_role" {
  name = "eks-cluster-role"
  # IAM role in order to create AWS on behalf of us
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

resource "aws_iam_role_policy_attachment" "ekl_amazon_eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.iam_eks_role.name
}

resource "aws_eks_cluster" "ekl_stack_cluster" {
  name     = "ekl_stack_cluster"
  version  = "1.24"
  role_arn = aws_iam_role.iam_eks_role.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.private_us_east_1a.id,
      aws_subnet.private_us_east_1b.id,
      aws_subnet.public_us_east_1a.id,
      aws_subnet.public_us_east_1b.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.ekl_amazon_eks_cluster_policy]
}