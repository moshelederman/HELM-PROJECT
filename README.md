# Project Stars

## Overview
Project Stars is a cloud-native application that leverages CI/CD pipelines, containerization, infrastructure as code, and monitoring tools to automate deployment and management on Google Kubernetes Engine (GKE).

## Features
- **Continuous Integration & Deployment (CI/CD)** using GitHub Actions.
- **Security Analysis** using Bandit.
- **Containerization** using Docker & Docker Compose.
- **Infrastructure as Code** using Terraform for GKE setup.
- **Helm Charts** for Kubernetes deployment.
- **Monitoring & Logging** using Prometheus, Grafana, and Loki.
- **GitOps** using ArgoCD for automated deployments.
- **Automated cleanup** of old Docker images.

## Technologies Used
- **CI/CD**: GitHub Actions
- **Containerization**: Docker, Docker Compose
- **Orchestration**: Kubernetes (GKE)
- **Infrastructure as Code**: Terraform
- **Deployment Management**: Helm
- **Monitoring & Logging**: Prometheus, Grafana, Loki
- **GitOps**: ArgoCD
- **Security**: Bandit (Python security scanner)

## Setup & Installation
### Prerequisites
Ensure you have the following installed:
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Kubernetes CLI (kubectl)](https://kubernetes.io/docs/tasks/tools/)
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [Helm](https://helm.sh/docs/intro/install/)
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)

### Clone the repository
```sh
git clone https://github.com/your-repo/project-stars.git
cd project-stars
```

### Run locally with Docker Compose
```sh
cd app
docker-compose up --build -d
```

### Deploy using Terraform & Helm
#### 1. Initialize and apply Terraform configuration
```sh
terraform init
terraform apply -auto-approve
```

#### 2. Configure `kubectl` to use GKE
```sh
gcloud container clusters get-credentials $GKE_CLUSTER_NAME --region $GKE_REGION
```

#### 3. Install application using Helm
```sh
helm upgrade --install project-stars ./mychart
```

## CI/CD Workflow
### Build Job
1. **Checkout Code** - Fetches the latest code from GitHub.
2. **Security Scan** - Runs Bandit for security analysis.
3. **Docker Setup** - Installs Docker & Docker Compose.
4. **Build & Push Docker Image** - Builds the application and pushes the image to Docker Hub.
5. **Helm Packaging** - Packages and pushes the Helm chart.

### Terraform Job
1. **Setup Terraform** - Installs Terraform and authenticates with GCP.
2. **Terraform Apply** - Deploys infrastructure using Terraform.

### Deploy Job
1. **Configure GKE** - Sets up `kubectl` and `gcloud`.
2. **Install Monitoring Tools** - Deploys Prometheus, Grafana, and Loki.
3. **Deploy Application** - Installs the Helm chart and restarts deployments if needed.
4. **Install ArgoCD** - Deploys ArgoCD for GitOps.

### Cleanup Job
1. **Delete Old Docker Images** - Removes Docker images older than 30 days from Docker Hub.

## Accessing the Application
Once deployed, you can access the application at:
```sh
kubectl get svc --all-namespaces | grep -v '<none>' | awk '{print "web url: http://"$2":5000"}'
```

### Grafana Credentials
```sh
kubectl get secret --namespace monitor grafana -o jsonpath="{.data.admin-password}" | base64 --decode
```

### ArgoCD Credentials
```sh
kubectl get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" -n argocd | base64 --decode
```

## Contributing
1. Fork the repository.
2. Create a feature branch.
3. Commit your changes.
4. Push to the branch and open a Pull Request.

## License
This project is licensed under the MIT License.

