# k2ss-infra

![Lint Status](https://github.com/gotoeveryone/k2ss-infra/workflows/CI/badge.svg)

## Requirements

- [Terraform CLI](https://www.terraform.io/docs/cli-index.html)
- [tfsec](https://aquasecurity.github.io/tfsec/v1.28.1/)

## Commands

### Terraform

```console
$ cd {repository_root}/terraform
$ cp terraform.tfvars.example terraform.tfvars # please edit values
```

#### Init

```console
$ terraform init
```

#### Plan

```console
$ terraform plan
```

#### Apply

```console
$ terraform apply
```

#### tfsec

```console
$ tfsec
```
