#!/usr/bin/env bash
set -euo pipefail

# This bootstraps:
# - ArgoCD (GitOps)
# - Cilium (CNI)
# - Crossplane (control plane for infra)
# - Karmada (multi-cluster scheduler)
# - Open Cluster Management (governance/placement)

REPO_URL="${REPO_URL:-https://YOUR_GIT_REPO_URL_HERE}"
REPO_BRANCH="${REPO_BRANCH:-main}"

echo "Using REPO_URL=${REPO_URL}"
echo "Using REPO_BRANCH=${REPO_BRANCH}"

kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -

echo "Installing ArgoCD (official manifests)..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "Waiting for ArgoCD API server..."
kubectl -n argocd rollout status deploy/argocd-server --timeout=10m

echo "Applying ArgoCD Project + Root App..."
kubectl apply -f platform/argocd/projects/platform-project.yaml
kubectl apply -f platform/argocd/root-app.yaml

echo "Done. ArgoCD will reconcile platform apps from repo."
echo "To access ArgoCD UI quickly (lab):"
echo "  kubectl -n argocd port-forward svc/argocd-server 8080:443"
echo "Admin password (initial):"
echo "  kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d; echo"
