# Complete Module Example

Configuration in this directory creates:

- LLM Model (e.g. Mistral 7B) deployed to EKS with helm and vLLM.

## Usage

To run this example you need to execute:

```bash
terraform init
terraform plan
terraform apply
```

Note that this example may create resources which will incur monetary charges on your AWS bill. Run `terraform destroy` when you no longer need these resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.19 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vllm_mistral_7b"></a> [vllm\_mistral\_7b](#module\_vllm\_mistral\_7b) | ../.. | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.

<!-- END_TF_DOCS -->

Apache-2.0 Licensed. See [LICENSE](https://github.com/clowdhaus/terraform-aws-<TODO>/blob/main/LICENSE).
