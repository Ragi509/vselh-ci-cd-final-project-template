#!/bin/bash
# ==============================================================================
# CI/CD Capstone Project - Part B (OpenShift & Tekton Pipeline Run)
# Run inside the IBM Skills Network lab terminal
# ==============================================================================
set -e

export MY_NAMESPACE=${SN_ICR_NAMESPACE:-$(oc project -q 2>/dev/null || echo "default")}
echo "Using namespace: $MY_NAMESPACE"

# 1. Clone or pull latest repository
cd ~
if [ ! -d "vselh-ci-cd-final-project-template" ]; then
  git clone https://github.com/Ragi509/vselh-ci-cd-final-project-template.git
fi
cd vselh-ci-cd-final-project-template
git pull origin main

# 2. Install cluster tasks from Tekton catalog / hub if not already present
tkn hub install task git-clone 2>/dev/null || oc apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.9/git-clone.yaml || true
tkn hub install task flake8 2>/dev/null || true
tkn hub install task buildah 2>/dev/null || true
tkn hub install task openshift-client 2>/dev/null || true

# 3. Apply custom Tekton Tasks (cleanup, nose)
oc apply -f .tekton/tasks.yml

# 4. Apply PersistentVolumeClaim
oc apply -f .tekton/pvc.yml

# 5. Apply Tekton Pipeline
oc apply -f .tekton/pipeline.yml

# 6. Start PipelineRun
echo "Starting Tekton Pipeline cd-pipeline..."
tkn pipeline start cd-pipeline \
  -w name=pipeline-workspace,claimName=pipelinerun-pvc \
  -p repo-url="https://github.com/Ragi509/vselh-ci-cd-final-project-template.git" \
  -p branch="main" \
  -p build-image="image-registry.openshift-image-registry.svc:5000/$MY_NAMESPACE/hit-counter:latest" \
  --use-param-defaults \
  --showlog

# 7. Validation / Status
echo "=== Pipeline Run Describe ==="
tkn pipelinerun describe --last

echo "=== Deployments and Routes ==="
oc get deployments
oc get pods
oc get routes
