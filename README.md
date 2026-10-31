# Customer Accounts Microservice (DevOps Capstone Project)

[![Build Status](https://github.com/Ragi509/vselh-ci-cd-final-project-template/actions/workflows/ci-build.yaml/badge.svg)](https://github.com/Ragi509/vselh-ci-cd-final-project-template/actions/workflows/ci-build.yaml)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Python 3.9](https://img.shields.io/badge/Python-3.9-green.svg)](https://shields.io/)

This repository contains the RESTful microservice for Customer Accounts as part of the DevOps Capstone Project. It provides full lifecycle management of customer accounts with automated testing, CI/CD pipelines via GitHub Actions and Tekton, containerization using Docker, and deployment to Kubernetes.

## Features
- **RESTful API**: Full CRUD operations (Create, Read, Update, Delete, List) for Customer Accounts.
- **Security**: Security headers with Flask-Talisman and Cross-Origin Resource Sharing (CORS) with Flask-CORS.
- **TDD / BDD**: Comprehensive test suite using nosetests with >95% code coverage.
- **CI Pipeline**: Automated linting and unit testing via GitHub Actions.
- **CD Pipeline**: Automated build and deployment to OpenShift/Kubernetes using Tekton Pipelines.