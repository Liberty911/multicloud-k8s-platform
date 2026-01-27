#!/usr/bin/env bash
set -euo pipefail

need() { command -v "$1" >/dev/null 2>&1 || { echo "Missing: $1"; exit 1; }; }

echo "Checking required tools..."
need aws
need terraform
need kubectl
need helm

echo "OK: aws/terraform/kubectl/helm found."

echo "Tip:"
echo "  export AWS_PROFILE=tf-user"
echo "  export AWS_REGION=us-east-1"
