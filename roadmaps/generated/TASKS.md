# XPlan — WowFreight + XCodeSuite

_Generated from roadmap: _

## E01 — "Foundations & repo hygiene"

- [ ] **T001** — "Init mono repo & tooling"
- [ ] **T002** — "Add README, LICENSE, CODEOWNERS"
- [ ] **T003** — "Add .gitignore and basic CI"
- [ ] **T004** — "Adopt conventional commits + commitlint"
- [ ] **T005** — "Prettier + ESLint shared config"
- [ ] **T006** — "EditorConfig + templates (PR, Issue)"
- [ ] **T007** — "CI cache + node/yarn/pnpm matrix"
- [ ] **T008** — "Security: npm audit + dependabot"
- [ ] **T009** — "Docs: CONTRIBUTING + quickstart"

## E02 — "Local DX, XCodeBox validation"

- [ ] **T010** — "Wire xcode CLI (validate) into repo"
- [ ] **T011** — "Add sample scenarios & invariants"
- [ ] **T012** — "npm scripts: xcode:validate, :report"
- [ ] **T013** — "HTML report publishing artifact"
- [ ] **T014** — "Watch mode + local web preview"
- [ ] **T015** — "Add adapters for http/base URLs"
- [ ] **T016** — "Refactor rules folder conventions"
- [ ] **T017** — "Readme: how to add a new rule"
- [ ] **T018** — "CI gate on score threshold"

## E03 — "WowFreight business scenarios"

- [ ] **T019** — "Order lifecycle: create→confirm→ship"
- [ ] **T020** — "Cancel only from DRAFT"
- [ ] **T021** — "Role-gated dispatch"
- [ ] **T022** — "Price recompute on item change"
- [ ] **T023** — "Taxes: optional but >= 0"
- [ ] **T024** — "Totals = sum(qty*price) ± tolerance"
- [ ] **T025** — "Non-empty items invariant"
- [ ] **T026** — "Valid states invariant"
- [ ] **T027** — "Shipment id propagation checks"

## E04 — "Reflexia integration & prompts"

- [ ] **T028** — "Prompts: insight-invariant"
- [ ] **T029** — "Prompts: scenario-failure analysis"
- [ ] **T030** — "Prompts: PR template"
- [ ] **T031** — "Wire prompts to report output"
- [ ] **T032** — "MCP tool: xcode.validate"
- [ ] **T033** — "MCP tool: xcode.publish"
- [ ] **T034** — "Memobox stream for findings"
- [ ] **T035** — "Track evidence links in JSON"
- [ ] **T036** — "Reflexia README for maintainers"

## E05 — "TrackBox scenarios & invariants"

- [ ] **T037** — "Trackbox: basic list invariants"
- [ ] **T038** — "Shipment tracking state machine"
- [ ] **T039** — "ETA regression checks (rolling)"
- [ ] **T040** — "Webhooks scenario validation"
- [ ] **T041** — "Auth headers and roles in steps"
- [ ] **T042** — "Consolidated report per domain"
- [ ] **T043** — "Trackbox adapter config YAML"
- [ ] **T044** — "Sample data fixtures loader"
- [ ] **T045** — "Docs: TrackBox onboarding"

## E06 — "Quality gates & alerts"

- [ ] **T046** — "Scores: PASS/FAIL thresholds"
- [ ] **T047** — "Slack/Telegram alert on FAIL"
- [ ] **T048** — "Fail-fast on rule-crash"
- [ ] **T049** — "Large files / repo hygiene rules"
- [ ] **T050** — "License scanning (OSS)"
- [ ] **T051** — "Secrets scanning pre-commit"
- [ ] **T052** — "Flaky scenario detector"
- [ ] **T053** — "Trend charts (7/30/90 days)"
- [ ] **T054** — "Nightly deep validation pipeline"

## E07 — "DX: speed & ergonomics"

- [ ] **T055** — "Hot reload for rules"
- [ ] **T056** — "Generator: new rule/scenario"
- [ ] **T057** — "Rule perf timings report"
- [ ] **T058** — "Local data snapshots"
- [ ] **T059** — "CLI: --tags, --grep, --since"
- [ ] **T060** — "JSON schema for YAML files"
- [ ] **T061** — "Type hints for adapters"
- [ ] **T062** — "Docs site (mkdocs/docusaurus)"
- [ ] **T063** — "Examples catalog"

## E08 — "Release, packaging, and ops"

- [ ] **T064** — "Pack bin wrappers (xcode/xcodebox)"
- [ ] **T065** — "Docker image for CI runners"
- [ ] **T066** — "Versioning & changelog"
- [ ] **T067** — "GitHub Actions reusable workflows"
- [ ] **T068** — "GH Pages: publish HTML reports"
- [ ] **T069** — "Artifacts retention policy"
- [ ] **T070** — "Perf budget in CI"
- [ ] **T071** — "Self-check rule suite"
- [ ] **T072** — "Adoption playbook"
