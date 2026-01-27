#!/usr/bin/env bash
set -euo pipefail

export AWS_REGION="${AWS_REGION:-us-east-1}"
TF_DIR="infra/terraform/aws"

pushd "${TF_DIR}" >/dev/null
terraform init
terraform apply -auto-approve
CLUSTER_NAME="$(terraform output -raw cluster_name)"
popd >/dev/null

echo "Cluster: ${CLUSTER_NAME}"
echo "Updating kubeconfig..."
aws eks update-kubeconfig --region "${AWS_REGION}" --name "${CLUSTER_NAME}"

kubectl get nodes -o wide
