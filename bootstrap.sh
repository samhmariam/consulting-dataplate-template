#!/usr/bin/env bash
set -euo pipefail

echo "🔧 Bootstrapping development environment..."

# -----------------------------
# Detect project root
# -----------------------------
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
cd "$PROJECT_ROOT"

# -----------------------------
# Check if running in devcontainer
# -----------------------------
if [ -n "${REMOTE_CONTAINERS:-}" ]; then
    echo "📦 Running in devcontainer - using system Python with pre-installed packages"
    # Skip venv creation in devcontainer since packages are already installed globally

    # Clean up any stale .venv that might have been synced from host (e.g., Windows)
    if [ -d ".venv" ]; then
        echo "🧹 Removing stale .venv directory (incompatible with devcontainer)..."
        rm -rf .venv
    fi
else
    echo "💻 Running locally - setting up virtual environment with uv"

    # Ensure uv exists
    if ! command -v uv &>/dev/null; then
        echo "❌ uv not found. Please install it first."
        exit 1
    fi

    # Create uv venv (idempotent)
    if [ ! -d ".venv" ]; then
        echo "📦 Creating Python virtual environment via uv..."
        uv venv .venv
    else
        echo "📦 Virtual environment already exists. Skipping creation."
    fi

    # Activate it
    echo "📦 Activating venv..."
    source .venv/bin/activate

    # Install dependencies
    if [ -f "pyproject.toml" ]; then
        echo "📚 Installing dependencies from pyproject.toml via uv..."
        uv pip install -r <(uv pip compile --quiet pyproject.toml)
    elif [ -f "requirements-dev.txt" ]; then
        echo "📚 Installing dependencies from requirements-dev.txt..."
        uv pip install -r requirements-dev.txt
    else
        echo "⚠️ No pyproject.toml or requirements-dev.txt found."
    fi
fi

# -----------------------------
# Pre-commit setup
# -----------------------------
if command -v pre-commit &>/dev/null && [ -d ".git" ]; then
    echo "🧹 Installing pre-commit hooks..."
    pre-commit install || echo "⚠️ pre-commit install failed (not critical)"
else
    echo "⚠️ Skipping pre-commit setup (not in a git repo or pre-commit not installed)"
fi

# -----------------------------
# Optional: initialize dbt deps
# -----------------------------
if [ -d "dbt" ] && command -v dbt &>/dev/null; then
    if [ -f "dbt/dbt_project.yml" ]; then
        echo "🏗️ Running dbt deps (inside dbt/)..."
        (
            cd dbt
            dbt deps
        ) || echo "⚠️ dbt deps failed (may be expected if profiles not configured yet)."
    else
        echo "⚠️ Skipping dbt deps (dbt/dbt_project.yml not found)."
    fi
fi

# -----------------------------
# Optional: initialize Dagster state dirs
# -----------------------------
if [ -d "dagster_app" ]; then
    mkdir -p dagster_app/.dagster_home
    echo "📁 Ensured dagster_app/.dagster_home exists."
fi

echo "🎉 Bootstrap complete."
