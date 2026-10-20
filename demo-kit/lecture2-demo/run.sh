#!/usr/bin/env bash
set -e
# variables you may update to target the correct file
IMAGE_NAME="lecture2-demo"
CONTAINER_NAME="lecture2-container"
# this will rebuild the image within the docker engine
echo "Building image: $IMAGE_NAME"
docker build -t "$IMAGE_NAME" .
# this will run the container and automatically remove it upon completion
echo "Running container with bind mount..."
docker run --rm --name "$CONTAINER_NAME" "$IMAGE_NAME"
