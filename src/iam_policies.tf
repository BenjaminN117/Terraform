
/// Policies used by multiple Groups ///



resource "aws_iam_policy" "terraform_s3_restriction" {
  name        = "terraform-s3-restriction"
  description = "Restricts access to Terraform S3 Bucket"
  policy = jsonencode({
    
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Deny",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::dev-terraform-profile",
                "arn:aws:s3:::dev-terraform-profile/*"
            ]
        }
    ]
  }
  )
}

resource "aws_iam_policy" "billing_restriction" {
  name        = "billing_restriction"
  description = "Restricts billing access"
  policy = jsonencode({
    
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Deny",
            "Action": [
                "billing:*",
                "consolidatedbilling:*",
                "cur:*",
                "freetier:*",
                "invoicing:*",
                "payments:*",
                "purchase-orders:*",
                "tax:*",
                "billingconductor:*"
            ],

            "Resource": "*"
        }
    ]
  }
  )
}



