# Quickstart

This guide walks a new contributor through configuring secrets, installing dependencies, and running the core tooling (Dagster, dbt, Terraform). The steps work both inside the devcontainer and on a local workstation as long as a POSIX shell (bash/zsh) is available.

## 1. Prerequisites

- **Git + VS Code (or any editor)** – clone the repository and open it with devcontainer support if desired.
- **Docker Desktop** – required only when using the prebuilt `.devcontainer/` environment.
- **Python 3.10+ with [uv](https://github.com/astral-sh/uv)** – the bootstrap script relies on uv to create and manage the virtual environment when you are *not* inside the devcontainer.
- **Bash shell** – macOS/Linux have it by default; Windows users can run the steps from WSL2, Git Bash, or inside the VS Code devcontainer.
- **Snowflake (or target warehouse) credentials** – needed for dbt + Dagster resources. Copy `.env.example` to `.env` and populate the values you have.

## 2. Clone and configure secrets

```bash
git clone git@github.com:samhmariam/consulting-dataplate-template.git
cd consulting-dataplate-template
cp .env.example .env  # use copy .env.example .env on Windows PowerShell
```

Fill in the Snowflake-specific values in `.env`. The file is git-ignored but loaded by both Dagster resources and dbt's starter profile.

## 3. Run the bootstrap script

```bash
./scripts/bootstrap.sh
# Windows (PowerShell) can call: bash scripts/bootstrap.sh
```

What the script does:

1. Detects whether you are inside the devcontainer. If not, it creates (or reuses) a `.venv` managed by uv and installs dependencies from `pyproject.toml` (or `requirements-dev.txt` if present).
2. Installs `pre-commit` hooks when the CLI is available so formatters and linters run before each commit.
3. Runs `dbt deps` inside the `dbt/` directory to download packages (fails gracefully if profiles are not configured yet).
4. Ensures `dagster_app/.dagster_home` exists so local Dagster runs have a place to store instance state.

Re-run the script any time dependencies change; it is idempotent.

## 4. Launch the Dagster development server

```bash
cd dagster_app
dagster dev
```

- The CLI reads `workspace.yaml` to load the `data_platform` code location.
- Visit `http://127.0.0.1:3000` to view software-defined assets, launch runs, and inspect logs.
- Use `.env` or VS Code secrets to expose credentials to Dagster resources.

## 5. Work with dbt

```bash
cd dbt
# Verify connectivity
dbt debug
# Build or test as needed
dbt build
```

- The checked-in `profiles/profiles.yml` expects secrets from environment variables (e.g., `SNOWFLAKE_ACCOUNT`).
- Organize models inside `models/staging|intermediate|marts` and keep `schema.yml` tests close to the SQL files.

## 6. Plan infrastructure with Terraform

```bash
cd infra/terraform/envs/dev
terraform init
terraform plan
```

Each environment folder (`dev`, `stg`, `prod`) wires the shared modules found in `infra/terraform/modules/`. Provide backend/variable values via the corresponding `terraform.tfvars` or CI secrets; never hard-code credentials in the repo.

## 7. Common troubleshooting

- **`uv` not found** – install it via `pip install uv`, Homebrew (`brew install uv`), or follow the [official docs](https://github.com/astral-sh/uv#installation). The bootstrap script will exit early otherwise.
- **dbt profile errors** – ensure `.env` is loaded in your shell (`source .env`) or export the variables manually. Running `dbt debug --config-dir` can help confirm which profile is active.
- **Dagster cannot reach Snowflake** – confirm `SNOWFLAKE_*` env vars are available to the Dagster process. In VS Code, add them to `.env` and enable `python.envFile` in settings.
- **Terraform backend auth failures** – verify that your cloud CLI (e.g., AWS or GCP) is logged in before running `terraform init`.

Once you can run Dagster, dbt, and Terraform locally, you are ready to implement assets, models, or infrastructure changes following the component-level READMEs.
