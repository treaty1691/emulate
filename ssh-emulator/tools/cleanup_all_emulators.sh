#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$ROOT_DIR"

COMPOSE_FILE="podman-compose.yml"
CONTAINERS=(aix1 brocade1 flash1)
IMAGE_KEYWORDS=(aix-emulator brocade-emulator flashsystem-emulator)

if command -v podman >/dev/null 2>&1; then
  RUNTIME=podman
  COMPOSE_CMD=(podman-compose -f "$COMPOSE_FILE")
elif command -v docker >/dev/null 2>&1; then
  RUNTIME=docker
  COMPOSE_CMD=(docker compose -f "$COMPOSE_FILE")
else
  echo "ERROR: podman-compose or docker is required to run cleanup." >&2
  exit 1
fi

echo "Bringing down compose services (if running)..."
"${COMPOSE_CMD[@]}" down --remove-orphans || true

for c in "${CONTAINERS[@]}"; do
  echo "Removing container: $c"
  if [ "$RUNTIME" = podman ]; then
    podman rm -f "$c" 2>/dev/null || true
  else
    docker rm -f "$c" 2>/dev/null || true
  fi
done

echo "Removing images matching keywords: ${IMAGE_KEYWORDS[*]}"
if [ "$RUNTIME" = podman ]; then
  for k in "${IMAGE_KEYWORDS[@]}"; do
    podman images --format '{{.Repository}}:{{.Tag}} {{.ID}}' | grep -E "$k" | awk '{print $2}' | xargs -r podman rmi -f || true
  done
else
  for k in "${IMAGE_KEYWORDS[@]}"; do
    docker images --format '{{.Repository}}:{{.Tag}} {{.ID}}' | grep -E "$k" | awk '{print $2}' | xargs -r docker rmi -f || true
  done
fi

echo "Cleanup complete."
