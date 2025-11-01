#!/bin/bash

# Set variables
ARGOCD_VERSION="v2.9.3"  # Specify your desired version
TARGET_DIR="../software-infra/argocd"

# Create target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Download ArgoCD installation manifest
echo "Downloading ArgoCD manifest version ${ARGOCD_VERSION}..."
curl -sSL "https://raw.githubusercontent.com/argoproj/argo-cd/${ARGOCD_VERSION}/manifests/install.yaml" > "${TARGET_DIR}/argocd-install.yaml"

# Split the single yaml into separate files (optional)
echo "Splitting manifest into separate files..."
csplit --quiet --prefix="${TARGET_DIR}/argocd-" "${TARGET_DIR}/argocd-install.yaml" "/^---$/" "{*}"

# Rename split files to be more meaningful (optional)
for file in "${TARGET_DIR}"/argocd-*; do
    if grep -q "kind: Deployment" "$file"; then
        mv "$file" "${TARGET_DIR}/argocd-deployment.yaml"
    elif grep -q "kind: Service" "$file"; then
        mv "$file" "${TARGET_DIR}/argocd-service.yaml"
    elif grep -q "kind: ConfigMap" "$file"; then
        mv "$file" "${TARGET_DIR}/argocd-configmap.yaml"
    fi
done

echo "ArgoCD manifests have been generated in ${TARGET_DIR}"
echo "You can now customize these files according to your needs."