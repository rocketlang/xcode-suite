#!/usr/bin/env bash
set -euo pipefail
ROOT="${1:-.}"; BM="${2:-.}"
echo "[1/4] Install sample deps"; pushd "$ROOT/examples/sample-repo" >/dev/null
npm i --silent
echo "[2/4] Run tests + lint"; npm run smoke --silent || true; popd >/dev/null
echo "[3/4] Copy reports & run runner"
mkdir -p "$ROOT/reports"
cp "$ROOT/examples/sample-repo/reports/coverage-summary.json" "$ROOT/reports/" 2>/dev/null || true
cp "$ROOT/examples/sample-repo/reports/eslint.json" "$ROOT/reports/" 2>/dev/null || true
export XCODE_MODULE="$ROOT/examples/sample-repo"
export XCODE_RULES_FILE="$BM/packages/xcodebox-core/core/xcode.rules.yaml"
npx tsx "$BM/packages/xcodebox-core/core/runner/xcode-runner.ts" || true
echo "[4/4] Done → $ROOT/reports/xcode_report.json"
