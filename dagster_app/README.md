# Dagster Project Structure

This folder hosts the Dagster project that orchestrates the data platform. The layout follows Dagster's recommended split between code locations and runtime state:

```
dagster_app/
├─ workspace.yaml             # Entry point used by `dagster dev`
├─ README.md                  # (this file) quick orientation for contributors
├─ .dagster_home/             # Runtime instance and storage (ignored in git except config)
└─ code_locations/
   └─ data_platform/
      ├─ assets/              # Software-defined assets grouped by domain
      ├─ jobs/                # Jobs composed from asset selections or graphs
      ├─ schedules/           # Scheduled materializations
      ├─ sensors/             # Event-based triggers
      ├─ resources/           # IO/resource definitions shared across assets
      └─ definitions.py       # Bundles assets + jobs into a Dagster `Definitions`
```

- Keep secrets and run history out of git by only committing `.dagster_home/dagster.yaml` (the rest is ephemeral).
- Add additional code locations under `code_locations/` when the project grows; update `workspace.yaml` to load each location.
- Use module-level docstrings or README files inside domain folders (`assets/warehouse/README.md`, etc.) to note ownership and data contracts.
