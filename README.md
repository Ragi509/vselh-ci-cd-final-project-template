# CI/CD Capstone Project

This project implements a complete Continuous Integration and Continuous Delivery (CI/CD) pipeline for a RESTful Hit Counter microservice built with Flask.

## Application Overview
The Hit Counter service provides a REST API to create, read, update, list, and delete hit counters. It is developed in Python with Flask and includes automated unit tests and code linting.

## GitHub Actions Workflow (CI)
The GitHub Actions workflow (`.github/workflows/workflow.yml`) automates Continuous Integration on every push and pull request to the `main` branch. It executes:
- **Lint with flake8**: Syntax and style checking enforcing PEP 8 guidelines and complexity limits.
- **Run unit tests with nose**: Automated unit test execution with `nosetests` including code coverage reporting.

## Tekton & OpenShift Pipeline (CD)
The cloud-native continuous delivery pipeline runs on Red Hat OpenShift using Tekton Pipelines. The pipeline automates:
1. **cleanup**: Clearing previous artifacts from the shared PersistentVolumeClaim (PVC) workspace.
2. **git-clone**: Cloning the application repository.
3. **flake8**: Static code analysis and linting.
4. **nose**: Unit testing and coverage verification.
5. **buildah**: Building an OCI-compliant container image and pushing to the OpenShift internal image registry.
6. **openshift-client**: Deploying the updated application image to OpenShift and verifying the service status.
