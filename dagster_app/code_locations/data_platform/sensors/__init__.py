"""Dagster sensors trigger event-driven workloads."""

from dagster import RunRequest, sensor

from ..jobs import FULL_REFRESH_JOB


@sensor(job=FULL_REFRESH_JOB)
def manual_backfill_sensor(context):
    """Simple sensor placeholder; replace with warehouse- or queue-based triggers."""

    if context.cursor is None:
        return RunRequest(run_key="initial-backfill")
    return None


SENSORS = [manual_backfill_sensor]

__all__ = ["SENSORS", "manual_backfill_sensor"]
