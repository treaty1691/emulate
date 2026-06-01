#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$ROOT_DIR"

COMPOSE_FILE="podman-compose.yml"
SERVICE="aix1"

if command -v podman-compose >/dev/null 2>&1; then
  COMPOSE_CMD=(podman-compose -f "$COMPOSE_FILE")
  RUNTIME=podman
elif command -v docker >/dev/null 2>&1; then
  COMPOSE_CMD=(docker compose -f "$COMPOSE_FILE")
  RUNTIME=docker
else
  echo "ERROR: podman-compose or docker command is required." >&2
  exit 1
fi

echo "Stopping and removing service container '$SERVICE'..."
"${COMPOSE_CMD[@]}" down --remove-orphans || true

if [ "$RUNTIME" = podman ]; then
  podman rm -f "$SERVICE" 2>/dev/null || true
  echo "Removing AIX-related Podman image(s)..."
  podman images --format '{{.Repository}}:{{.Tag}} {{.ID}}' | grep -E 'aix|aix-emulator' | awk '{print $2}' | xargs -r podman rmi -f || true
  echo "Rebuilding AIX emulator image from Containerfile..."
  podman build --no-cache -t ssh-emulator-aix-emulator -f aix-emulator/Containerfile aix-emulator
else
  docker rm -f "$SERVICE" 2>/dev/null || true
  echo "Removing AIX-related Docker image(s)..."
  docker images --format '{{.Repository}}:{{.Tag}} {{.ID}}' | grep -E 'aix|aix-emulator' | awk '{print $2}' | xargs -r docker rmi -f || true
  echo "Rebuilding AIX emulator image from Containerfile..."
  docker build --no-cache -t ssh-emulator-aix-emulator -f aix-emulator/Containerfile aix-emulator
fi

echo "Rebuild complete."
