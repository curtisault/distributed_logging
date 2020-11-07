#!/usr/bin/env bash
set -euo pipefail

echo "Getting deps"

rm -rf _build/ deps/ node/
mix deps.get
mix deps.compile
mix compile

echo "Running Elixir. Run ./test.sh in new session."
mix run --no-halt
