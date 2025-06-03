# tozd/redis

<https://gitlab.com/tozd/docker/redis>

Available as:

- [`tozd/redis`](https://hub.docker.com/r/tozd/redis)
- [`registry.gitlab.com/tozd/docker/redis`](https://gitlab.com/tozd/docker/redis/container_registry)

## Image inheritance

[`tozd/base`](https://gitlab.com/tozd/docker/base) ← [`tozd/dinit`](https://gitlab.com/tozd/docker/dinit) ← `tozd/postgresql`

## Tags

- `3`: Redis 3.2.13
- `4`: Redis 4.0.14
- `5`: Redis 5.0.14
- `6`: Redis 6.2.18
- `7`: Redis 7.4.4
- `8`: Redis 8.0.2

## Volumes

- `/var/log/redis`: Log files when `LOG_TO_STDOUT` is not set to `1`.
- `/etc/redis/conf.d`: You can put Redis config files with `.conf` file extension here to configure the server.
- `/data`: Persist this volume to not lose state when Redis is configured with persistence.

## Variables

- `LOG_TO_STDOUT`: If set to `1` output logs to stdout (retrievable using `docker logs`) instead of log volumes.

## Ports

- `6379/tcp`: Port on which Redis listens.

## Description

Image providing [Redis](https://redis.io/) server.

Different Docker tags provide different Redis versions.

You should make sure you mount data volume (`/data`) when you configure Redis with persistence
so that you do not lose data when you are recreating a container.

When `LOG_TO_STDOUT` is set to `1`, Docker image logs output to stdout and stderr. All stdout output is JSON.

## GitHub mirror

There is also a [read-only GitHub mirror available](https://github.com/tozd/docker-redis),
if you need to fork the project there.
