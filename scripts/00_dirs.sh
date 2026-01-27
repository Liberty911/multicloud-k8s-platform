#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="multicloud-k8s-platform"

mkdir -p "${ROOT_DIR}"/{scripts,infra/terraform/aws,platform/{argocd/{apps,projects},cilium,crossplane/{install,providers,aws},karmada,ocm}}

touch "${ROOT_DIR}/README.md"
touch "${ROOT_DIR}/.gitignore"

echo "Created repo structure under: ${ROOT_DIR}"
