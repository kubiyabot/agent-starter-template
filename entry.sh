#!/bin/bash
set -eu
set -o pipefail

# Agent configuration
VERSION=${VERSION:-"0.1.1"}

APISERVER=https://kubernetes.default.svc
SERVICEACCOUNT=/var/run/secrets/kubernetes.io/serviceaccount
NAMESPACE=$(cat ${SERVICEACCOUNT}/namespace)
TOKEN=$(cat ${SERVICEACCOUNT}/token)
CACERT=${SERVICEACCOUNT}/ca.crt


# Configure kubectl
kubectl config set-cluster cfc --server=${APISERVER} --certificate-authority=${CACERT}
kubectl config set-context cfc --cluster=cfc
kubectl config set-credentials user --token=${TOKEN}
kubectl config set-context cfc --user=user
kubectl config use-context cfc

# Argo CD login with --core for in-cluster access
echo "Attempting to set up Argo CD with in-cluster access"
if argocd login --core; then
    echo "Logged into Argo CD successfully."
else
    echo "Argo CD login failed - probably not installed."
fi

# Utility environment variables
export TF_CLI_ARGS='-no-color'

# Run the main application
echo "Starting Kubiya Agent - Version: ${VERSION} (https://docs.kubiya.ai)"
if [ ! -x "/code/dist/main/main" ]; then
    echo "Error: Agent application binary not found or not executable."
    exit 1
fi

/code/dist/main/main
