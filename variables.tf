variable "eks" {
  description = "EKS cluster information. Only cluster_name is required by this module."
  type = object({
    cluster_name = string
  })
}

variable "vllm" {
  description = "vllm helm module settings"
  type = object({
    enabled      = bool
    force_update = bool
  })
  default = {
    enabled      = true
    force_update = true
  }
}

variable "k8s" {
  description = "Kubernetes-related settings for the helm release"
  type = object({
    create_namespace          = bool
    kubernetes_namespace      = string
    service_account_namespace = string
    service_account_name      = string
    iam_role_enabled          = bool
  })
  default = {
    create_namespace          = true
    kubernetes_namespace      = "vllm"
    service_account_namespace = "vllm"
    service_account_name      = "vllm-sa"
    iam_role_enabled          = true
  }
}

variable "helm" {
  description = "Helm client options"
  type = object({
    atomic               = bool
    cleanup_on_fail      = bool
    timeout              = number
    wait                 = bool
    values_template_path = optional(string)
  })
  default = {
    atomic          = true
    cleanup_on_fail = true
    timeout         = 300
    wait            = true
  }
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
