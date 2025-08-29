#!/usr/bin/env bash
set -euo pipefail
echo "Preparing app ..."

# Create Docker network if not exists
if ! docker network inspect myapp-net >/dev/null 2>&1; then
  docker network create myapp-net
  echo "Created network: myapp-net"
else
  echo "Network myapp-net already exists."
fi

# Create persistent volume if not exists
if ! docker volume inspect myapp-db >/dev/null 2>&1; then
  docker volume create myapp-db
  echo "Created volume: myapp-db"
else
  echo "Volume myapp-db already exists."
fi

# Build Flask app image
docker build -t my-flask-app ./flask-app

echo "Preparation complete."
