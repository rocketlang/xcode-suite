#!/usr/bin/env bash
set -euo pipefail
BASE="/root/xcode/roadmaps"
OUT="$BASE/generated"
ROADMAP="${1:-$BASE/cmxbox-roadmap.yaml}"
MODE="${2:-}"  # --issues to publish GH issues

echo "🧩 CMX self: roadmap=$ROADMAP"
test -s "$ROADMAP" || { echo "Missing roadmap: $ROADMAP"; exit 2; }

bash "$BASE/xplan_expand.sh" ROADMAP="$ROADMAP" OUTBASE="$BASE"
bash "$BASE/xplan_publish.sh" ROADMAP="$ROADMAP" OUTBASE="$BASE" >/dev/null

ok=1
for url in http://localhost:8089/run http://localhost:8090/health http://localhost:8088/health; do
  if curl -s --max-time 2 "$url" >/dev/null; then
    echo "  ✅ up: $url"
  else
    echo "  ⚠️  down: $url"
    ok=0
  fi
done

if [[ "$MODE" == "--issues" ]]; then
  REPO="${REPO:-rocketlang/xcode-suite}"
  ROADMAP="$ROADMAP" OUTBASE="$BASE" TASKS_MD="$OUT/TASKS.md" REPO="$REPO" \
    bash "$BASE/xplan_publish.sh" --issues
fi

echo "📄 Tasks dir: $OUT/tasks  (count: $(ls -1 "$OUT/tasks" 2>/dev/null | wc -l || echo 0))"
echo "📝 Checklist: $OUT/TASKS.md"
[[ $ok -eq 1 ]] && echo "✅ Doctor OK" || echo "⚠️  Doctor found issues"
