"""Bundle Dagster assets, jobs, resources, and schedules into a single Definitions object."""

from dagster import Definitions

from .assets import ASSETS
from .jobs import ASSET_JOBS
from .resources import RESOURCE_DEFINITIONS
from .schedules import SCHEDULES
from .sensors import SENSORS


defs = Definitions(
    assets=ASSETS,
    jobs=ASSET_JOBS,
    resources=RESOURCE_DEFINITIONS,
    schedules=SCHEDULES,
    sensors=SENSORS,
)
