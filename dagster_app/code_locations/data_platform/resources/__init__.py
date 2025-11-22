"""Shared Dagster resource definitions."""

from dagster import Field, InitResourceContext, resource


@resource(config_schema={"example_param": Field(str, is_required=False)})
def example_resource(context: InitResourceContext):
    """Stub resource showing where to place database or API clients."""

    context.log.debug("Bootstrapping example resource with config: %s", context.resource_config)
    return {"client": None}


RESOURCE_DEFINITIONS = {
    "example_resource": example_resource,
}

__all__ = ["RESOURCE_DEFINITIONS", "example_resource"]
