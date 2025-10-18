#!/usr/bin/env bash
set -euo pipefail

BASE="/root/xcode/roadmaps"
OUT="$BASE/generated"
ALIASES="$HOME/.proot_aliases_inside"

mkdir -p "$BASE" "$OUT"

# 1) cmx_self.sh (self-enhancement / doctor / optional issues)
cat >"$BASE/cmx_self.sh" <<'SH'
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
SH
chmod +x "$BASE/cmx_self.sh"

# 2) HELP + README
cat >"$OUT/CMXBOX_HELP.md" <<'MD'
# CMXBox — quick help

**Common commands**
- `cmxself`     – run self-enhancement/doctor
- `cmxissues`   – same + open/update GitHub issues
- `cmxplan`     – expand roadmap → per-task YAMLs
- `cmxpub`      – rebuild TASKS.md
- `cmxopen`     – serve generated/ at http://127.0.0.1:8098/
- `cmxreadme`   – show long README

**Files**
- Roadmap:    /root/xcode/roadmaps/cmxbox-roadmap.yaml
- Tasks dir:  /root/xcode/roadmaps/generated/tasks/
- Checklist:  /root/xcode/roadmaps/generated/TASKS.md
MD

cat >"$OUT/CMXBOX_README.md" <<'MD'
# CMXBox (Control & Monitor XCodeSuite)

CMXBox coordinates the boxes (XCodeBox, MCPBox, Reflexia, TrackBox, WowFreight):
- schedules checks, validates scores/SLOs,
- correlates failures, escalates alerts,
- opens issues, sends reports.

## Quick start
cmxplan     # expand roadmap
cmxpub      # regenerate TASKS.md
cmxself     # doctor + refresh
cmxissues   # as above + GitHub issues (set REPO=owner/name)
cmxopen     # serve docs on :8098
MD

# 3) Aliases block (idempotent refresh)
TMP="$(mktemp)"
if [ -f "$ALIASES" ]; then
  awk '
    BEGIN{skip=0}
    /^# >>> CMXBox aliases BEGIN >>>/{skip=1; next}
    /^# <<< CMXBox aliases END <<</{skip=0; next}
    skip==0{print}
  ' "$ALIASES" > "$TMP" && mv "$TMP" "$ALIASES"
fi
cat >>"$ALIASES" <<'EOF'
# >>> CMXBox aliases BEGIN >>>
alias cmxplan='bash /root/xcode/roadmaps/xplan_expand.sh ROADMAP=/root/xcode/roadmaps/cmxbox-roadmap.yaml OUTBASE=/root/xcode/roadmaps'
alias cmxpub='bash /root/xcode/roadmaps/xplan_publish.sh ROADMAP=/root/xcode/roadmaps/cmxbox-roadmap.yaml OUTBASE=/root/xcode/roadmaps'
alias cmxself='bash /root/xcode/roadmaps/cmx_self.sh /root/xcode/roadmaps/cmxbox-roadmap.yaml'
alias cmxissues='REPO=${REPO:-rocketlang/xcode-suite} bash /root/xcode/roadmaps/cmx_self.sh /root/xcode/roadmaps/cmxbox-roadmap.yaml --issues'
alias cmxopen='python3 -m http.server 8098 -d /root/xcode/roadmaps/generated'
alias cmxhelp='sed -n "1,200p" /root/xcode/roadmaps/generated/CMXBOX_HELP.md || echo "Run: cmxplan && cmxpub to generate"'
alias cmxreadme='sed -n "1,200p" /root/xcode/roadmaps/generated/CMXBOX_README.md || echo "Run: cmxplan && cmxpub to generate"'
# <<< CMXBox aliases END <<<
EOF

# shellcheck disable=SC1090
source "$ALIASES"

echo "✅ Installed:"
echo "  - $BASE/cmx_self.sh"
echo "  - $OUT/CMXBOX_HELP.md"
echo "  - $OUT/CMXBOX_README.md"
echo "✅ Aliases ready: cmxplan cmxpub cmxself cmxissues cmxopen cmxhelp cmxreadme"
