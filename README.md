# 🦀 Rust Hello World Backend with Helm & GitHub Actions

This project is a simple Rust backend using Actix Web, deployed via Helm on Kubernetes with full CI/CD automation.

## 🚀 Features

- Rust backend with Actix Web
- Dockerized and deployed via Helm
- GitHub Actions CI/CD pipeline
- Per-PR test environments on Kubernetes
- Automatic cleanup on PR close/merge


# GitHub Actions workflow

---

## 🧪 Local Development

### Run Locally

```bash
cargo run
```
# Visit http://localhost:8080


Run Tests
cargo test



🐳 Docker
Build & Run
```bash
docker build -t rust-hello .
docker run -p 8080:8080 rust-hello
```


☸️ Kubernetes Deployment with Helm
Manual Deployment
```bash
helm upgrade --install hello-backend ./helm/hello-backend \
  --namespace my-namespace \
  --set image.repository=ghcr.io/bikboy/app_backend \
  --set image.tag=latest \
  --set ingress.hosts[0].host=my-namespace.yourdomain.com
```


🔐 GitHub Secrets Required
|  |  | 
| KUBECONFIG |  | 
| GITHUB_TOKEN |  | 



🧪 GitHub Actions CI/CD Pipeline
Triggered On
- pull_request events: opened, synchronized, reopened, closed
Workflow Steps
- Build & Test
- Compile Rust app
- Run unit/integration tests
- Build Docker image
- Push to GitHub Container Registry
- Deploy
- Create a Kubernetes namespace per PR (pr-<PR_NUMBER>)
- Deploy app using Helm
- Comment test URL on PR
- Cleanup
- Delete namespace when PR is closed or merged
Example Helm Install in CI
```bash
helm upgrade --install hello-backend ./helm/hello-backend \
  --namespace pr-123 \
  --set image.repository=ghcr.io/your-org/hello-backend \
  --set image.tag=pr-123 \
  --set ingress.hosts[0].host=pr-123.yourdomain.com
```


📣 Reviewer Instructions
- Open a PR with your changes
- Wait for GitHub Actions to deploy your version
- Visit the test URL posted as a comment on the PR
- Merge or close PR to trigger cleanup

## ☁️ Cloud Deployment

### 🚀 Deploying to AWS EKS

#### 1. Create EKS Cluster
```bash
aws eks create-cluster \
  --name my-cluster \
  --role-arn arn:aws:iam::<ACCOUNT_ID>:role/EKSRole \
  --resources-vpc-config subnetIds=subnet-abc,subnet-def,securityGroupIds=sg-xyz
```
#### 2. Update kubeconfig
```bash
aws eks update-kubeconfig --name my-cluster --region <region>
```

#### 3. Push Image to Amazon ECR
```bash
aws ecr create-repository --repository-name hello-backend
docker tag rust-hello:latest <AWS_ACCOUNT_ID>.dkr.ecr.<region>.amazonaws.com/hello-backend:latest
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <AWS_ACCOUNT_ID>.dkr.ecr.<region>.amazonaws.com
docker push <AWS_ACCOUNT_ID>.dkr.ecr.<region>.amazonaws.com/hello-backend:latest
```

#### 4. Deploy via Helm
```bash
helm upgrade --install hello-backend ./helm/hello-backend \
  --namespace my-namespace --create-namespace \
  --set image.repository=<AWS_ACCOUNT_ID>.dkr.ecr.<region>.amazonaws.com/hello-backend \
  --set image.tag=latest
```
### Deploying to GCP GKE
#### 1. Create GKE Cluster
```bash
gcloud container clusters create my-cluster \
  --zone us-central1-a \
  --num-nodes 3
```

#### 2. Get Cluster Credentials
```bash
gcloud container clusters get-credentials my-cluster --zone us-central1-a
```

#### 3. Push Image to Google Artifact Registry
```bash
gcloud artifacts repositories create hello-backend-repo \
  --repository-format=docker \
  --location=us-central1 \
  --description="Docker repo for hello-backend"
docker tag rust-hello:latest us-central1-docker.pkg.dev/<PROJECT_ID>/hello-backend-repo/hello-backend:latest
gcloud auth configure-docker us-central1-docker.pkg.dev
docker push us-central1-docker.pkg.dev/<PROJECT_ID>/hello-backend-repo/hello-backend:latest
```
#### 4. Deploy via Helm
```bash
helm upgrade --install hello-backend ./helm/hello-backend \
  --namespace my-namespace --create-namespace \
  --set image.repository=us-central1-docker.pkg.dev/<PROJECT_ID>/hello-backend-repo/hello-backend \
  --set image.tag=latest
```

