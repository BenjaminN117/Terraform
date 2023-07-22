terraform {
  required_version = ">= 1.2.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

/// Group Creation ///

resource "aws_iam_group" "developers_group" {
  name = "developers_group"
  // "Used for standard developers"
  path = "/users/"
}

resource "aws_iam_group" "elevated_developers_group" {
  name = "elevated_developers_group"
  // "Used for developers who also need access to IAM management"
  path = "/users/"
}

resource "aws_iam_group" "billing_group" {
  name = "billing_group"
  // "Used for developers who also need access to IAM management"
  path = "/users/"
}


/// Policy Creation ///

resource "aws_iam_group_policy" "developers_policy" {
  name = "developers_policy"
  // "Access policy for standard developers - Uses the PowerUser Role (Rev.5)"
  group = aws_iam_group.developers_group.name

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "NotAction": [
                "iam:*",
                "organizations:*",
                "account:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:CreateServiceLinkedRole",
                "iam:DeleteServiceLinkedRole",
                "iam:ListRoles",
                "organizations:DescribeOrganization",
                "account:ListRegions",
                "account:GetAccountInformation"
            ],
            "Resource": "*"
        }
    ]
  }
  )
}

resource "aws_iam_group_policy" "elevated_developers_policy" {
  name = "elevated_developers_policy"
  // "Elevated policy for developers - Uses AdministratorAccess (Rev.1)"
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
  // "Billing"
  group = aws_iam_group.billing_group.name
  policy = jsonencode({
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "VisualEditor0",
			"Effect": "Allow",
			"Action": [
				"budgets:CreateBudgetAction",
				"budgets:ExecuteBudgetAction",
				"budgets:DescribeBudgetAction",
				"budgets:DescribeBudgetActionHistories",
				"budgets:DeleteBudgetAction",
				"budgets:UpdateBudgetAction"
			],
			"Resource": "arn:aws:budgets::457964009758:budget/*/action/*"
		},
		{
			"Sid": "VisualEditor1",
			"Effect": "Allow",
			"Action": [
				"budgets:ViewBudget",
				"budgets:DescribeBudgetActionsForBudget",
				"budgets:ModifyBudget"
			],
			"Resource": "arn:aws:budgets::457964009758:budget/*"
		},
		{
			"Sid": "VisualEditor2",
			"Effect": "Allow",
			"Action": [
				"aws-portal:ViewAccount",
				"aws-portal:GetConsoleActionSetEnforced",
				"aws-portal:ViewBilling",
				"budgets:DescribeBudgetActionsForAccount",
				"tax:*",
				"aws-portal:ViewUsage"
			],
			"Resource": "*"
		},
		{
			"Sid": "VisualEditor3",
			"Effect": "Allow",
			"Action": [
				"ce:UpdateNotificationSubscription",
				"ce:DeleteNotificationSubscription",
				"ce:DeleteReport",
				"ce:GetCostAndUsage",
				"ce:GetReservationPurchaseRecommendation",
				"ce:GetPreferences",
				"ce:ListSavingsPlansPurchaseRecommendationGeneration",
				"ce:GetReservationUtilization",
				"ce:UpdateReport",
				"ce:GetCostCategories",
				"ce:GetSavingsPlansPurchaseRecommendation",
				"ce:GetSavingsPlansUtilizationDetails",
				"ce:GetDimensionValues",
				"ce:UpdateCostAllocationTagsStatus",
				"ce:StartSavingsPlansPurchaseRecommendationGeneration",
				"ce:CreateCostCategoryDefinition",
				"ce:DescribeReport",
				"ce:GetReservationCoverage",
				"ce:CreateAnomalyMonitor",
				"ce:CreateReport",
				"ce:GetUsageForecast",
				"ce:DescribeNotificationSubscription",
				"ce:GetRightsizingRecommendation",
				"ce:CreateNotificationSubscription",
				"ce:GetSavingsPlansUtilization",
				"ce:CreateAnomalySubscription",
				"ce:ListCostCategoryDefinitions",
				"ce:GetCostForecast",
				"ce:UpdateConsoleActionSetEnforced",
				"ce:GetCostAndUsageWithResources",
				"ce:ListCostAllocationTags",
				"ce:UpdatePreferences",
				"ce:ProvideAnomalyFeedback",
				"ce:GetSavingsPlansCoverage",
				"ce:GetConsoleActionSetEnforced",
				"ce:GetTags"
			],
			"Resource": "*",
			"Condition": {
				"Bool": {
					"aws:MultiFactorAuthPresent": "true"
				}
			}
		},
		{
			"Sid": "VisualEditor4",
			"Effect": "Allow",
			"Action": "budgets:*",
			"Resource": "arn:aws:budgets::457964009758:budget/*/action/*"
		},
		{
			"Sid": "VisualEditor5",
			"Effect": "Allow",
			"Action": "budgets:*",
			"Resource": "arn:aws:budgets::457964009758:budget/*"
		},
		{
			"Sid": "VisualEditor6",
			"Effect": "Allow",
			"Action": "ce:*",
			"Resource": [
				"arn:aws:ce::457964009758:costcategory/*",
				"arn:aws:ce::457964009758:anomalysubscription/*",
				"arn:aws:ce::457964009758:anomalymonitor/*"
			],
			"Condition": {
				"Bool": {
					"aws:MultiFactorAuthPresent": "true"
				}
			}
		}
	]
})
}