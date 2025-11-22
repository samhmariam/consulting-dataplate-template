# Start from the base image
FROM mcr.microsoft.com/devcontainers/python:3.11-bookworm

# -----------------------------
# System dependencies + Docker CLI
# -----------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates gnupg lsb-release \
    build-essential jq make unzip \
    git \
    docker.io \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------
# GitHub CLI (gh) - pinned via .deb
# -----------------------------
ARG GH_VERSION=2.54.0
RUN ARCH="$(dpkg --print-architecture)" \
 && curl -fsSL "https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_${ARCH}.deb" \
    -o /tmp/gh.deb \
 && apt-get update \
 && apt-get install -y /tmp/gh.deb \
 && rm /tmp/gh.deb \
 && gh --version

# -----------------------------
# Terraform (pinned) - FIXED: Use dynamic architecture
# -----------------------------
ARG TF_VERSION=1.6.6
RUN ARCH="$(dpkg --print-architecture)" \
 && curl -fsSL "https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_${ARCH}.zip" \
    -o /tmp/terraform.zip \
 && unzip /tmp/terraform.zip -d /usr/local/bin \
 && rm /tmp/terraform.zip \
 && terraform -version

# -----------------------------
# uv (pinned) - fast Python env + package manager
# -----------------------------
ARG UV_VERSION=0.4.20
RUN pip install --no-cache-dir "uv==${UV_VERSION}" \
 && uv --version

# -----------------------------
# dbt-core + Snowflake adapter (pinned)
# -----------------------------
ARG DBT_VERSION=1.8.4
RUN uv pip install --system \
    "dbt-core==${DBT_VERSION}" \
    "dbt-snowflake==${DBT_VERSION}"

# -----------------------------
# Dagster (pinned)
# -----------------------------
RUN uv pip install --system \
    "dagster==1.12.3" \
    "dagster-webserver==1.12.3" \
    "dagster-postgres==0.28.3"

# Dagster pulls grpcio-health-checking<1.63 which cannot import google.protobuf.runtime_version;
# align with dbt constraints by pinning the older protobuf and grpcio-health-checking pair.
RUN uv pip install --system \
    "protobuf<5" \
    "grpcio-health-checking<1.63"
    
# -----------------------------
# Python Tooling (all pinned) + awscli v1
# -----------------------------
RUN uv pip install --system \
    "pre-commit==3.7.0" \
    "black==24.4.2" \
    "ruff==0.6.3" \
    "mypy==1.11.1" \
    "pytest==8.3.1" \
    "python-dotenv==1.0.1" \
    "snowflake-connector-python==3.10.0" \
    "sqlfluff==3.1.0" \
    "sqlfluff-templater-dbt==3.1.0"

# -----------------------------
# Optional: AWS CLI v2 installation (alternative to the pip install above)
# This requires commenting out the 'awscli' pip install line above.
# -----------------------------
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip \
 && ./aws/install \
 && rm -rf awscliv2.zip aws \
 && aws --version

# -----------------------------
# Workspace
# -----------------------------
WORKDIR /workspaces
USER vscode
