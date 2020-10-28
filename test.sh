#!/usr/bin/env bash
set -euo pipefail

echo "Running Tests"

mix deps.get
mix deps.clean --unused

mix test
