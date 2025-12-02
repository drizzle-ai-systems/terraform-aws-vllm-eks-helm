provider "aws" {
  region = local.region
}

locals {
  region = "eu-central-1"
  name   = "vllm-mistral-7b"


  tags = {
    Name       = local.name
    Example    = local.name
    Repository = "https://github.com/drizzle-ai-systems/terraform-aws-vllm-eks-helm"
  }
}

################################################################################
# vLLM Mistral 7B Module
################################################################################

module "vllm_mistral_7b" {
  source = "../.."

  eks = {
    cluster_name = "eks-vllm-cluster" # cluster name needs to be existing
  }

  vllm = {
    enabled      = true
    force_update = true
  }

  k8s = {
    create_namespace          = true
    kubernetes_namespace      = "vllm-mistral-7b"
    service_account_namespace = "vllm-mistral-7b"
    service_account_name      = "vllm-mistral-7b-sa"
    iam_role_enabled          = true
  }

  helm = {
    atomic               = true
    cleanup_on_fail      = true
    timeout              = 300
    wait                 = true
    values_template_path = "${path.module}/helm/values-mistral-7b.yaml"
  }

  tags = local.tags
}
