#!/usr/bin/env bash
set -euo pipefail

EXT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
SERVERS_DIR="$EXT_DIR/servers"

# Name the venv for this server
VENV="$SERVERS_DIR/toonmcp"
PYTHON_BIN="${PYTHON_BIN:-python3}"

NODE_MODULES_BIN="$SERVERS_DIR/node_modules/.bin"
TOON_BIN="$NODE_MODULES_BIN/toon-format"

# -------------------------------------------------------------------
# 0) Sanity check: node / npm must exist on the box
# -------------------------------------------------------------------
if ! command -v node >/dev/null 2>&1; then
  echo "[toon] ERROR: 'node' is not installed or not on PATH." >&2
  echo "[toon] Please install Node.js (16+ recommended) before using this MCP." >&2
  exit 1
fi

if ! command -v npm >/dev/null 2>&1; then
  echo "[toon] ERROR: 'npm' is not installed or not on PATH." >&2
  echo "[toon] Please install npm (comes with Node.js) before using this MCP." >&2
  exit 1
fi

# -------------------------------------------------------------------
# 0.5) Ensure @toon-format/cli is installed locally (idempotent)
#      All output -> STDERR so STDOUT stays clean for MCP
# -------------------------------------------------------------------
if [ ! -x "$TOON_BIN" ]; then
  echo "[toon] Installing @toon-format/cli into $SERVERS_DIR/node_modules ..." >&2
  (
    cd "$SERVERS_DIR"
    npm install --no-fund --no-audit @toon-format/cli
  ) 1>&2
else
  echo "[toon] @toon-format/cli already installed – skipping npm install." >&2
fi

# Make sure our locally installed toon CLI is discoverable
export PATH="$NODE_MODULES_BIN:$PATH"

# -------------------------------------------------------------------
# 1) Create venv if missing
# -------------------------------------------------------------------
if [ ! -x "$VENV/bin/python3" ]; then
  echo "[toon] Creating venv at $VENV" >&2
  "$PYTHON_BIN" -m venv "$VENV" 1>&2
  "$VENV/bin/pip" install -U pip wheel setuptools \
    --disable-pip-version-check -q 1>&2
fi

# -------------------------------------------------------------------
# 2) Ensure Python deps (idempotent). All output -> STDERR.
# -------------------------------------------------------------------
if [ -f "$SERVERS_DIR/requirements.txt" ]; then
  echo "[toon] Installing Python requirements from $SERVERS_DIR/requirements.txt ..." >&2
  "$VENV/bin/pip" install -r "$SERVERS_DIR/requirements.txt" \
    --disable-pip-version-check --no-input -q 1>&2
fi

# -------------------------------------------------------------------
# 3) Exec the MCP server
#    This must be the ONLY thing that writes to STDOUT.
# -------------------------------------------------------------------
exec "$VENV/bin/python3" "$SERVERS_DIR/toon_mcp.py"
