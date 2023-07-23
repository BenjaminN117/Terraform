/// Groups and Policy Creation ///

resource "aws_iam_group" "developers_group" {
  name = "developers_group"
  // "Used for standard developers - Does not allow access to Terraform config"
  path = "/users/developers"
}

resource "aws_iam_group" "elevated_developers_group" {
  name = "elevated_developers_group"
  // "Used for developers who also need access to Terraform config
  path = "/users/elevated_developers"
}

resource "aws_iam_group" "billing_group" {
  name = "billing_group"
  // Used for staff that need only billing access
  path = "/users/billing"
}

/// Policy Creation ///

resource "aws_iam_group_policy" "developers_policy" {
  name = "developers_policy"
  group = aws_iam_group.developers_group.name

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
        },
        
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]

  }
  )
}

resource "aws_iam_group_policy" "elevated_developers_policy" {
  name = "elevated_developers_policy"
  group = aws_iam_group.elevated_developers_group.name
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
})
}

resource "aws_iam_group_policy" "billing_policy" {
  name = "billing_policy"
  group = aws_iam_group.billing_group.name
  policy = jsonencode({
	"Version": "2012-10-17",
	"Statement": [
			{
            "Effect": "Allow",
            "Action": [
                "account:GetAccountInformation",
                "aws-portal:*Billing",
                "aws-portal:*PaymentMethods",
                "aws-portal:*Usage",
                "billing:GetBillingData",
                "billing:GetBillingDetails",
                "billing:GetBillingNotifications",
                "billing:GetBillingPreferences",
                "billing:GetContractInformation",
                "billing:GetCredits",
                "billing:GetIAMAccessPreference",
                "billing:GetSellerOfRecord",
                "billing:ListBillingViews",
                "billing:PutContractInformation",
                "billing:RedeemCredits",
                "billing:UpdateBillingPreferences",
                "billing:UpdateIAMAccessPreference",
                "budgets:ModifyBudget",
                "budgets:ViewBudget",
                "ce:CreateNotificationSubscription",
                "ce:CreateReport",
                "ce:DeleteNotificationSubscription",
                "ce:DeleteReport",
                "ce:UpdateNotificationSubscription",
                "ce:UpdatePreferences",
                "ce:UpdateReport",
                "consolidatedbilling:GetAccountBillingRole",
                "consolidatedbilling:ListLinkedAccounts",
                "cur:DeleteReportDefinition",
                "cur:DescribeReportDefinitions",
                "cur:GetClassicReport",
                "cur:GetClassicReportPreferences",
                "cur:GetUsageReport",
                "cur:ModifyReportDefinition",
                "cur:PutClassicReportPreferences",
                "cur:PutReportDefinition",
                "cur:ValidateReportDestination",
                "freetier:GetFreeTierAlertPreference",
                "freetier:GetFreeTierUsage",
                "freetier:PutFreeTierAlertPreference",
                "invoicing:GetInvoiceEmailDeliveryPreferences",
                "invoicing:GetInvoicePDF",
                "invoicing:ListInvoiceSummaries",
                "invoicing:PutInvoiceEmailDeliveryPreferences",
                "payments:CreatePaymentInstrument",
                "payments:DeletePaymentInstrument",
                "payments:GetPaymentInstrument",
                "payments:GetPaymentStatus",
                "payments:ListPaymentPreferences",
                "payments:MakePayment",
                "payments:UpdatePaymentPreferences",
                "purchase-orders:AddPurchaseOrder",
                "purchase-orders:DeletePurchaseOrder",
                "purchase-orders:GetPurchaseOrder",
                "purchase-orders:ListPurchaseOrderInvoices",
                "purchase-orders:ListPurchaseOrders",
                "purchase-orders:ListTagsForResource",
                "purchase-orders:ModifyPurchaseOrders",
                "purchase-orders:TagResource",
                "purchase-orders:UntagResource",
                "purchase-orders:UpdatePurchaseOrder",
                "purchase-orders:UpdatePurchaseOrderStatus",
                "purchase-orders:ViewPurchaseOrders",
                "tax:BatchPutTaxRegistration",
                "tax:DeleteTaxRegistration",
                "tax:GetExemptions",
                "tax:GetTaxInheritance",
                "tax:GetTaxInterview",
                "tax:GetTaxRegistration",
                "tax:GetTaxRegistrationDocument",
                "tax:ListTaxRegistrations",
                "tax:PutTaxInheritance",
                "tax:PutTaxInterview",
                "tax:PutTaxRegistration",
                "tax:UpdateExemptions"
            ],
            "Resource": "*"
        },
		
		{
			"Effect": "Deny",
			"Action": "*",
			"Resource": "*"
		}
	]
})
}