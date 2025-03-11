# k2ss-infra

![Lint Status](https://github.com/gotoeveryone/k2ss-infra/workflows/CI/badge.svg)

## Requirements

- [Terraform CLI](https://www.terraform.io/docs/cli-index.html)
- [tfsec](https://aquasecurity.github.io/tfsec/v1.28.1/)
- [Pipenv](https://pipenv-ja.readthedocs.io/ja/translate-ja/)

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

### Ansible

```console
$ cd {repository_root}/ansible
$ cp hosts.example hosts # please edit values
$ cp vars/user.yml.example vars/user.yml # please edit values
$ cp vars/mysql.yml.example vars/mysql.yml # please edit values
$
$ pipenv install
$ pipenv run install
$ pipenv run setup_certificate -u {user_name} --private-key {private_key_path}
$ pipenv run setup -u {user_name} --private-key {private_key_path}
```
