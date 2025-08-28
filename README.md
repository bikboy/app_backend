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
# Visit http://localhost:8080


Run Tests
cargo test



🐳 Docker
Build & Run
docker build -t rust-hello .
docker run -p 8080:8080 rust-hello



☸️ Kubernetes Deployment with Helm
Manual Deployment
helm upgrade --install hello-backend ./helm/hello-backend \
  --namespace my-namespace \
  --set image.repository=ghcr.io/bikboy/app_backend \
  --set image.tag=latest \
  --set ingress.hosts[0].host=my-namespace.yourdomain.com



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
helm upgrade --install hello-backend ./helm/hello-backend \
  --namespace pr-123 \
  --set image.repository=ghcr.io/your-org/hello-backend \
  --set image.tag=pr-123 \
  --set ingress.hosts[0].host=pr-123.yourdomain.com



📣 Reviewer Instructions
- Open a PR with your changes
- Wait for GitHub Actions to deploy your version
- Visit the test URL posted as a comment on the PR
- Merge or close PR to trigger cleanup

