# Consulting Dataplate Template

An opinionated reference stack for data platform engagements. It bundles orchestration, transformation, and infrastructure tooling so project teams can start with consistent conventions instead of wiring the basics from scratch.

## Stack Overview

- **Dagster orchestration (`dagster_app/`)** – software-defined assets, schedules, and sensors for coordinating pipelines and platform operations.
- **dbt transformations (`dbt/`)** – modular SQL models, tests, and documentation for Snowflake (or another warehouse) using the staging → intermediate → marts pattern.
- **Terraform infrastructure (`infra/terraform/`)** – reusable modules plus per-environment stacks for Dagster, dbt runners, Snowflake, and Airbyte ingestion.
- **Bootstrap tooling (`scripts/`)** – a single `bootstrap.sh` script that creates the Python environment, installs dependencies, wires pre-commit, and primes dbt/Dagster state whether you run locally or inside the devcontainer.
- **Operational glue (`logs/`, `.env`, `.devcontainer/`)** – shared conventions for logging, secrets management via env vars, and a portable VS Code devcontainer.

## Repository Layout

| Path | Purpose |
| --- | --- |
| `dagster_app/` | Dagster workspace plus the `data_platform` code location.
| `dbt/` | Core dbt project, checked-in profiles scaffold, and downloaded packages.
| `infra/terraform/` | Environment folders under `envs/` and reusable modules under `modules/`.
| `scripts/` | Automation helpers (currently `bootstrap.sh`).
| `.env.example` | Minimal Snowflake credential template—copy to `.env` for local work.
| `.devcontainer/` | VS Code container definition preloaded with CLI tools.

## Getting Started

1. Copy `.env.example` to `.env` and fill in warehouse-specific values (Snowflake account, role, etc.).
2. Run `./scripts/bootstrap.sh` (or `bash scripts/bootstrap.sh` on Windows/WSL). The script detects devcontainer vs. local shells, sets up a uv-managed virtualenv when needed, installs Python deps, registers pre-commit hooks, runs `dbt deps`, and ensures `dagster_app/.dagster_home` exists.
3. Follow `docs/quickstart.md` for detailed workflows (Dagster dev server, dbt CLI usage, Terraform plans, and common troubleshooting).

## Documentation Map

- `docs/quickstart.md` – step-by-step bootstrap + workflow guide.
- `dagster_app/README.md` – Dagster-specific layout notes.
- `dbt/README.md` – dbt modeling conventions.
- `infra/terraform/README.md` – infrastructure module guidance.

Contributions should extend this documentation whenever you add a major component or workflow so new teammates can ramp quickly.
