#!/bin/bash

CONTAINER="debusine-dev"
IMAGE="docker.io/library/debian:sid"
PROJECT_PATH="/home/nikil/Desktop/Deb/debusine"

PODMAN="/usr/bin/podman"

# If container does not exist, create it
if ! $PODMAN container exists $CONTAINER; then
    echo "Creating container $CONTAINER..."
    $PODMAN run -dit \
        --name $CONTAINER \
        -p 8000:8000 \
        -p 8001:8001 \
        -v "$PROJECT_PATH":/app:Z \
        -w /app \
        $IMAGE \
        sleep infinity
fi

# If container exists but not running, start it
if ! $PODMAN ps --format "{{.Names}}" | grep -q "^$CONTAINER$"; then
    echo "Starting container $CONTAINER..."
    $PODMAN start $CONTAINER >/dev/null
fi

# Attach shell
exec $PODMAN exec -it $CONTAINER bash
