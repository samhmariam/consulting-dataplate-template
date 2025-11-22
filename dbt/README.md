# dbt Project Structure

```
dbt/
├─ README.md                # Contributor guidance
├─ dbt_project.yml          # Core project configuration
├─ packages.yml             # External packages (dbt-utils, dbt-labs, etc.)
├─ profiles/                # Checked-in starter profile for devcontainers
│  └─ profiles.yml
├─ models/
│  ├─ staging/              # Source-aligned models with light transformations
│  ├─ intermediate/         # Business logic building blocks
│  └─ marts/                # End-user facing dimensional models
├─ seeds/                   # CSV seeds loaded via `dbt seed`
├─ snapshots/               # Slowly changing dimension definitions
├─ macros/                  # Reusable macro logic
├─ analyses/                # One-off analytical queries
└─ tests/                   # Data tests that do not fit in schema.yml
```

- Keep environment-specific credentials out of `profiles/`; rely on `.env` + env var interpolation instead.
- Align model folder names with ownership (e.g., `models/staging/sales/`), and include `schema.yml` files at each level for tests + documentation.
- Update `packages.yml` and rerun `dbt deps` when you add community packages.
