#!/usr/bin/env bash
set -euo pipefail
echo "Removing app ..."
docker rm -f my-flask >/dev/null 2>&1 || true
docker rm -f my-postgres >/dev/null 2>&1 || true
docker network rm myapp-net >/dev/null 2>&1 || true
docker volume rm myapp-db >/dev/null 2>&1 || true
docker rmi my-flask-app >/dev/null 2>&1 || true
echo "App removed (containers, image, network, and volume)."
