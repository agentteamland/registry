#!/usr/bin/env bash
# Local equivalent of the GitHub Actions "Validate Registry" workflow's
# offline checks. Runs the same ajv schema validation + duplicate check
# the CI runs, so that drift is caught BEFORE pushing — not after a
# failed PR check.
#
# Skips network checks (repo URL reachability, remote team.json fetches);
# those are intentionally CI-only because they're slow and flaky.

set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

if ! command -v ajv >/dev/null 2>&1; then
  echo "✗ ajv-cli not installed. Install once with:"
  echo "    npm install --global ajv-cli ajv-formats"
  exit 1
fi

echo "→ 1/2 Validating teams.json against schemas/registry.schema.json"
ajv validate -c ajv-formats \
  -s schemas/registry.schema.json \
  -d teams.json \
  --spec=draft2020 \
  --strict=false

echo "→ 2/2 Checking for duplicate team names"
node -e "
  const fs = require('fs');
  const d = JSON.parse(fs.readFileSync('teams.json', 'utf8'));
  const names = d.teams.map(t => t.name);
  const dupes = names.filter((n, i) => names.indexOf(n) !== i);
  if (dupes.length) { console.error('✗ Duplicate team names:', dupes); process.exit(1); }
  console.log('  no duplicates');
"

echo "✓ teams.json is valid"
