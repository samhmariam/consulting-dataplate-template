"""Dagster jobs built on top of the project's assets."""

from dagster import AssetSelection, define_asset_job

from ..assets import ASSETS


FULL_REFRESH_JOB = define_asset_job(
    name="full_refresh",
    selection=AssetSelection.keys(*(asset.key for asset in ASSETS)),
    description="Materializes every asset defined in the data platform.",
)


ASSET_JOBS = [FULL_REFRESH_JOB]

__all__ = ["ASSET_JOBS", "FULL_REFRESH_JOB"]
