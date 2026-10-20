#!/usr/bin/env bash
# After a dry run (and before Lecture 2): remove only what the lectures create,
# so "Unable to find image", "docker ps -a" and the rmi conflict happen fresh.
# Keeps alpine and the python images (pre-pull.sh) so class doesn't re-download.
#   bash demo-kit/reset.sh
LECTURE_IMAGES="hello-docker file-demo lecture2-demo"

# 1 · containers made from the lecture images, plus sleeper and lecture2-container
for img in $LECTURE_IMAGES hello-world; do
  ids=$(docker ps -aq --filter "ancestor=$img")
  [ -n "$ids" ] && docker rm -f $ids
done
docker rm -f sleeper lecture2-container 2>/dev/null || true

# 2 · then the images (containers first, then images: the lecture's own rule)
for img in $LECTURE_IMAGES; do
  docker rmi "$img" 2>/dev/null && echo "removed image $img" || true
done

echo "--- left over (should list no lecture containers):"
docker ps -a --format '{{.Names}}  {{.Image}}  {{.Status}}'
docker images
