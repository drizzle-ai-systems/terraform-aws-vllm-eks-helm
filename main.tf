
data "aws_eks_cluster" "this" {
  name = var.eks.cluster_name
}

module "vllm" {
  source = "./modules/helm-release"

  enabled      = try(var.vllm.enabled, true)
  force_update = try(var.vllm.force_update, true)

  chart         = "${path.module}/chart-helm"
  chart_version = "0.0.1"

  create_namespace          = try(var.k8s.create_namespace, true)
  kubernetes_namespace      = try(var.k8s.kubernetes_namespace, "vllm")
  service_account_namespace = try(var.k8s.service_account_namespace, "vllm")
  service_account_name      = try(var.k8s.service_account_name, "vllm-sa")
  iam_role_enabled          = try(var.k8s.iam_role_enabled, true)

  eks_cluster_oidc_issuer_url = data.aws_eks_cluster.this.identity[0].oidc[0].issuer

  atomic          = try(var.helm.atomic, true)
  cleanup_on_fail = try(var.helm.cleanup_on_fail, true)
  timeout         = try(var.helm.timeout, 300)
  wait            = try(var.helm.wait, true)

  values = [
    templatefile(
      var.helm.values_template_path != null ? var.helm.values_template_path : "./chart-helm/values.yaml.tpl",
      {}
    )
  ]

  tags = var.tags
}
