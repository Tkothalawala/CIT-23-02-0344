#!/usr/bin/env bash
set -euo pipefail
echo "Stopping app ..."
docker stop my-flask >/dev/null 2>&1 || true
docker stop my-postgres >/dev/null 2>&1 || true
echo "App stopped. Data is preserved in the 'myapp-db' volume."
