#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$ROOT_DIR"

if command -v podman >/dev/null 2>&1; then
  RUNTIME=podman
elif command -v docker >/dev/null 2>&1; then
  RUNTIME=docker
else
  echo "ERROR: podman or docker is required to run this test." >&2
  exit 1
fi

CONTAINER=aix1
if ! "$RUNTIME" inspect "$CONTAINER" >/dev/null 2>&1; then
  echo "ERROR: container '$CONTAINER' not found. Start it with podman-compose up -d --build or docker compose -f podman-compose.yml up -d --build." >&2
  exit 1
fi

OUTPUT="$($RUNTIME exec "$CONTAINER" bash -lc 'df -k' 2>&1 | sed 's/\r$//')"
EXPECTED_OUTPUT=$'Filesystem  kbytes  free  %used  mounted on\n/dev/hd4   10240   5120  50%  /'

if [[ "$OUTPUT" != "$EXPECTED_OUTPUT" ]]; then
  printf 'FAIL: df -k output did not match expected\n\nExpected:\n%s\n\nGot:\n%s\n' "$EXPECTED_OUTPUT" "$OUTPUT"
  exit 1
fi

printf 'PASS: df -k output is correct\n'
