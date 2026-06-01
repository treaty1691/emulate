#!/bin/bash
set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <ansible-vvv-log> <output-dir>"
  exit 1
fi

LOG="$1"
OUTDIR="$2"
mkdir -p "$OUTDIR"

grep -oP '(?<=EXEC ).*' "$LOG" | sort -u | while IFS= read -r CMD; do
  SAFE=$(echo "$CMD" | sed 's/[^A-Za-z0-9._-]/_/g')
  echo "Capture command: $CMD -> $SAFE.txt"
  printf '# captured output for: %s\n' "$CMD" > "$OUTDIR/${SAFE}.txt"
done
