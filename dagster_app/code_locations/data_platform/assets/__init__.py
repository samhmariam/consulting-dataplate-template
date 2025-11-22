"""Software-defined assets for the data platform."""

from dagster import AssetExecutionContext, asset


@asset(
    group_name="staging",
    description="Example placeholder asset. Replace with real logic.",
)
def example_source_table(context: AssetExecutionContext):
    """Placeholder asset illustrating the expected pattern for asset modules."""

    context.log.info(
        "Replace `example_source_table` with your real ingestion logic.")
    return []


ASSETS = [example_source_table]

__all__ = ["ASSETS", "example_source_table"]
