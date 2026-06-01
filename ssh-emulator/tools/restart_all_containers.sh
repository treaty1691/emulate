#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$ROOT_DIR"

COMPOSE_FILE="podman-compose.yml"
if [[ ! -f "$COMPOSE_FILE" ]]; then
  echo "ERROR: Compose file '$COMPOSE_FILE' not found in $ROOT_DIR." >&2
  exit 1
fi

if command -v podman-compose >/dev/null 2>&1; then
  COMPOSE_CMD=(podman-compose -f "$COMPOSE_FILE")
elif command -v docker >/dev/null 2>&1; then
  COMPOSE_CMD=(docker compose -f "$COMPOSE_FILE")
else
  echo "ERROR: podman-compose or docker is required to restart containers." >&2
  exit 1
fi

echo "Stopping all emulator containers..."
"${COMPOSE_CMD[@]}" down --remove-orphans

echo "Starting all emulator containers..."
"${COMPOSE_CMD[@]}" up -d

echo "All emulator containers have been restarted."
