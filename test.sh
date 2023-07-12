#!/bin/sh

set -e

cleanup_docker=0
cleanup() {
  set +e

  if [ "$cleanup_docker" -ne 0 ]; then
    echo "Logs"
    docker logs test

    echo "Stopping Docker image"
    docker stop test
    docker rm -f test
  fi
}

trap cleanup EXIT

echo "Running Docker image"
docker run -d --name test -e LOG_TO_STDOUT=1 -p 6379:6379 "${CI_REGISTRY_IMAGE}:${TAG}"
cleanup_docker=1

echo "Sleeping"
sleep 5

echo "Testing"
echo -e '*1\r\n$4\r\nPING\r\n' | nc -w1 docker 6379
echo "Success"
