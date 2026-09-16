#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
./compile.sh >/dev/null
payload="$(python3 - <<'PY'
print(" ".join(["-f"] * 20000), end="")
PY
)"
ulimit -s 8192 2>/dev/null || true
PIGZ="$payload" timeout 10s ./executable -V