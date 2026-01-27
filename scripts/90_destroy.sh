#!/usr/bin/env bash
set -euo pipefail

export AWS_REGION="${AWS_REGION:-us-east-1}"
TF_DIR="infra/terraform/aws"

pushd "${TF_DIR}" >/dev/null
terraform destroy -auto-approve
popd >/dev/null

echo "Destroyed AWS resources from terraform."
