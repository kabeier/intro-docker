#!/usr/bin/env bash
# Before Lecture 1: pull every image the lectures use, so nothing big
# downloads on class Wi-Fi from YOUR machine.
#   bash demo-kit/pre-pull.sh
set -e
for img in hello-world alpine:latest python:3.12-slim python:3.12-alpine python:3.12; do
  echo "Pulling $img"
  docker pull -q "$img"
done
docker images
