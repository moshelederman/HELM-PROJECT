![Diagram Stars Project](stars-project.drawio.svg)
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

### Clone the repository
```sh
git clone https://github.com/moshelederman/project-stars.git
```

### Deploy using Helm
#### Install application using Helm
```sh
helm pull oci://docker.io/moshelederman/project-stars
helm install [RELEASE_NAME] project-stars.tgz
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

### Accessing the Application
Once deployed, you can access the application at:

### Grafana Credentials

### ArgoCD Credentials

## Contributing
1. Fork the repository.
2. Create a feature branch.
3. Commit your changes.
4. Push to the branch and open a Pull Request.

## License
This project is licensed under the MIT License.

