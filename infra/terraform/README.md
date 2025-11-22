# Terraform Infrastructure

This folder standardizes infrastructure-as-code for Dagster, dbt, Snowflake, and Airbyte across environments. It follows the common split between reusable modules and environment-specific stacks to keep drift visible.

```
infra/terraform/
├─ README.md
├─ modules/
│  ├─ dagster/
│  ├─ dbt/
│  ├─ snowflake/
│  └─ airbyte/
└─ envs/
   ├─ dev/
   ├─ stg/
   └─ prod/
```

- Author resources inside `modules/` and expose clean variables/outputs.
- Compose entire environments under `envs/<env>` by instantiating the modules and wiring secrets via input variables (prefer remote state + CI-provided secrets).
- Keep provider backends (`backend.tf`) separate per environment so teams can migrate state without global changes.
- Run `terraform init` and `terraform plan` from within an environment directory; never from the repo root.
