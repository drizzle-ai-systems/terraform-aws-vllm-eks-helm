# vllm-eks-helm Terraform module

Terraform module which creates a vLLM workload on EKS and manage related Helm releases.

## Usage

See the `examples` directory for working examples to reference:

```hcl
module "vllm_mistral_7b" {
  source = "drizzle-ai-systems/vllm-eks-helm/aws"

  eks = {
    cluster_name = "eks-cluster" # cluster name needs to be existing
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
    atomic          = true
    cleanup_on_fail = true
    timeout         = 300
    wait            = true
    values_template_path = "${path.module}/helm/mistral-7b-values.yaml"
  }

  tags = local.tags
}

```

## Dependencies

- [helm release module by CloudPosse](https://github.com/cloudposse/terraform-aws-helm-release)
- [vLLM Helm chart](./chart-helm)

## Configure LLM Model with vLLM

This module is using the [vLLM Helm chart](./chart-helm) to deploy a vLLM workload on EKS. To configure your LLM model with vLLM, you need to create a values template file and pass it to the module using the `values_template_path` variable. See [vLLM Helm chart](./chart-helm) for more information.

## Examples

Examples codified under the [`examples`](https://github.com/drizzle-ai-systems/terraform-vllm-eks-helm/tree/main/examples) directory are intended to give users references for how to use the module(s) and for testing/validating changes to the module. If contributing, update the relevant examples so maintainers can test changes and users have up-to-date references.

- [Complete example](https://github.com/drizzle-ai-systems/terraform-vllm-eks-helm/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.19 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.19 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vllm"></a> [vllm](#module\_vllm) | ./modules/helm-release | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_eks_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eks"></a> [eks](#input\_eks) | EKS cluster information. Only cluster\_name is required by this module. | <pre>object({<br/>    cluster_name = string<br/>  })</pre> | n/a | yes |
| <a name="input_helm"></a> [helm](#input\_helm) | Helm client options | <pre>object({<br/>    atomic          = bool<br/>    cleanup_on_fail = bool<br/>    timeout         = number<br/>    wait            = bool<br/>    values_template_path = string<br/>  })</pre> | <pre>{<br/>  "atomic": true,<br/>  "cleanup_on_fail": true,<br/>  "timeout": 300,<br/>  "wait": true<br/>}</pre> | no |
| <a name="input_k8s"></a> [k8s](#input\_k8s) | Kubernetes-related settings for the helm release | <pre>object({<br/>    create_namespace          = bool<br/>    kubernetes_namespace      = string<br/>    service_account_namespace = string<br/>    service_account_name      = string<br/>    iam_role_enabled          = bool<br/>  })</pre> | <pre>{<br/>  "create_namespace": true,<br/>  "iam_role_enabled": true,<br/>  "kubernetes_namespace": "vllm",<br/>  "service_account_name": "vllm-sa",<br/>  "service_account_namespace": "vllm"<br/>}</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_vllm"></a> [vllm](#input\_vllm) | vllm helm module settings | <pre>object({<br/>    enabled      = bool<br/>    force_update = bool<br/>  })</pre> | <pre>{<br/>  "enabled": true,<br/>  "force_update": true<br/>}</pre> | no |

## Outputs

No outputs.


## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/drizzle-ai-systems/terraform-vllm-eks-helm/blob/main/LICENSE).
