# CloudDevOpsProject

# CloudDevOpsProject

<div align="center">

**Complete CI/CD Pipeline with Infrastructure as Code**

iVolve Cloud & DevOps Graduation Project

</div>

---

## 📋 Overview

CloudDevOpsProject is a comprehensive DevOps graduation project demonstrating modern CI/CD practices and cloud infrastructure automation. This project implements a complete pipeline for a Flask web application using Docker, Kubernetes, Terraform, Ansible, Jenkins, and ArgoCD on AWS.

---

## ✨ Features

- **Docker**: Containerized Flask application with optimized Dockerfile
- **Kubernetes**: Cluster orchestration with namespace isolation and 2 replicas
- **Terraform**: AWS infrastructure (VPC, EC2, S3, CloudWatch) with modular design
- **Ansible**: Automated EC2 configuration with dynamic inventory and roles
- **Jenkins**: CI/CD pipeline with Docker build, push, and manifest updates
- **ArgoCD**: GitOps continuous deployment with auto-sync and self-healing

---

## 🚀 Quick Start

### Prerequisites
- Docker, kubectl, Terraform, Ansible, Git
- GitHub, DockerHub, and AWS accounts

### Installation

```bash
# 1. Clone repository
git clone https://github.com/YOUR_USERNAME/CloudDevOpsProject.git
cd CloudDevOpsProject

# 2. Build and push Docker image
docker build -t your-dockerhub-username/ivolve:latest .
docker push your-dockerhub-username/ivolve:latest

# 3. Provision AWS infrastructure
cd terraform/
terraform init
terraform apply -auto-approve

# 4. Configure Jenkins server
cd ../ansible/
ansible-playbook -i inventory/aws_ec2.yaml playbook.yaml

# 5. Deploy to Kubernetes
cd ../kubernetes/
kubectl apply -f namespace.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

# 6. Setup ArgoCD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -f ../argocd/application.yaml

# 7. Get application URL
kubectl get svc ivolve-svc -n ivolve
```

---

## 📁 Project Structure

```
CloudDevOpsProject/
├── README.md                       # This file
├── Dockerfile                      # Container build instructions
├── app/                            # Flask application
│   ├── app.py
│   ├── requirements.txt
│   ├── templates/
│   └── static/
├── kubernetes/                     # K8s manifests
│   ├── namespace.yaml
│   ├── deployment.yaml
│   └── service.yaml
├── terraform/                      # Infrastructure as Code
│   ├── backend.tf
│   ├── main.tf
│   ├── variables.tf
│   └── modules/
│       ├── network/
│       └── server/
├── ansible/                        # Configuration management
│   ├── inventory/
│   ├── playbook.yaml
│   └── roles/
├── jenkins/                        # CI/CD pipeline
│   ├── Jenkinsfile
│   └── vars/
├── argocd/                         # GitOps deployment
│   └── application.yaml
└── docs/                           # Detailed documentation
    └── README.md
```

---

## 🛠️ Technology Stack

**Development:** Python 3.11, Flask  
**Containerization:** Docker  
**Orchestration:** Kubernetes  
**Infrastructure:** Terraform, AWS  
**Configuration:** Ansible  
**CI/CD:** Jenkins  
**GitOps:** ArgoCD  

---

## 📖 Documentation

For detailed documentation, please refer to the `docs/README.md` file which includes:

- Complete setup instructions for each component
- Architecture overview and design decisions
- Detailed usage guide and examples
- Comprehensive troubleshooting section
- Best practices and maintenance tips

---

## 🔄 CI/CD Workflow

1. **Developer pushes code** to GitHub
2. **Jenkins pipeline** triggers automatically:
   - Builds Docker image
   - Scans with Trivy (bonus)
   - Pushes to DockerHub
   - Updates Kubernetes manifests
3. **ArgoCD syncs** changes from Git
4. **Kubernetes deploys** new version with rolling update

---

## 🎯 Usage

### Deploy New Version
```bash
# Make changes and commit
git add .
git commit -m "Updated feature"
git push origin main

# Watch deployment
kubectl get pods -n ivolve -w
```

### Check Status
```bash
# Kubernetes
kubectl get all -n ivolve

# ArgoCD
kubectl get application ivolve-app -n argocd

# View logs
kubectl logs -f deployment/ivolve-web -n ivolve
```

---

## 🐛 Common Issues

**Pods not starting:**
```bash
kubectl describe pod POD_NAME -n ivolve
kubectl get events -n ivolve --sort-by='.lastTimestamp'
```

**Jenkins pipeline fails:**
```bash
sudo journalctl -u jenkins -f
# Check credentials in Jenkins UI
```

**ArgoCD not syncing:**
```bash
kubectl patch application ivolve-app -n argocd --type merge -p '{"operation":{"sync":{}}}'
```

For detailed troubleshooting, refer to the complete documentation in `docs/README.md`

---

## 📊 Project Deliverables

- [x] GitHub repository with complete structure
- [x] Dockerfile and containerized application
- [x] Kubernetes manifests (namespace, deployment, service)
- [x] Terraform infrastructure with modules
- [x] Ansible playbooks with roles and dynamic inventory
- [x] Jenkins pipeline with shared library
- [x] ArgoCD application manifest
- [x] Comprehensive documentation

### Bonus Features
- [x] Trivy image scanning
- [x] Jenkins slave as on-demand EC2
- [x] EKS cluster Terraform module

---

## 👥 Author

**iVolve Graduation Project**  
Cloud & DevOps Engineering Program  
In collaboration with NTI

---

<div align="center">

Made with ❤️ for the DevOps Community

</div>
