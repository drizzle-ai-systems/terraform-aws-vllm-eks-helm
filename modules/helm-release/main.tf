module "helm-release" {
  source  = "cloudposse/helm-release/aws"
  version = "0.10.1"

  repository    = var.repository
  chart         = var.chart
  chart_version = var.chart_version

  create_namespace_with_kubernetes = var.create_namespace
  kubernetes_namespace             = var.kubernetes_namespace
  service_account_namespace        = var.service_account_namespace
  service_account_name             = var.service_account_name
  iam_role_enabled                 = var.iam_role_enabled
  iam_source_policy_documents      = var.iam_source_policy_documents

  eks_cluster_oidc_issuer_url  = var.eks_cluster_oidc_issuer_url
  service_account_set_key_path = var.service_account_set_key_path

  atomic          = var.atomic
  cleanup_on_fail = var.cleanup_on_fail
  timeout         = var.timeout
  wait            = var.wait
  max_history     = var.max_history

  values        = var.values
  set_sensitive = var.set_sensitive

  context = module.this.context

  depends_on = [var.helm_release_depends_on]
}
