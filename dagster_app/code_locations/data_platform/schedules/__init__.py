"""Central place for all Dagster schedules."""

from dagster import ScheduleDefinition

from ..jobs import FULL_REFRESH_JOB


DAILY_FULL_REFRESH = ScheduleDefinition(
    name="daily_full_refresh",
    job=FULL_REFRESH_JOB,
    cron_schedule="0 2 * * *",
    execution_timezone="UTC",
    description="Kick off a full asset refresh every day at 02:00 UTC.",
)


SCHEDULES = [DAILY_FULL_REFRESH]

__all__ = ["SCHEDULES", "DAILY_FULL_REFRESH"]
