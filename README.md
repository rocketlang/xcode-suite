# XCode Quality Framework

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/yourorg/xcode)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Build](https://img.shields.io/badge/build-passing-brightgreen.svg)](https://github.com/yourorg/xcode)
[![Coverage](https://img.shields.io/badge/coverage-85%25-yellowgreen.svg)](coverage)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

> A comprehensive validation and testing framework for freight management systems (WowFreight, Reflexia, TrackBox). Build confidence in your logistics operations with automated quality checks, scenario testing, and continuous validation.

---

## 📚 Table of Contents

- [Why XCode?](#-why-xcode)
- [Key Features](#-key-features)
- [Quick Start](#-quick-start)
- [Installation](#-installation)
- [Usage](#-usage)
- [Project Structure](#-project-structure)
- [Task Management](#-task-management)
- [Development](#-development)
- [Contributing](#-contributing)
- [Testing](#-testing)
- [Troubleshooting](#-troubleshooting)
- [License](#-license)

---

## 🎯 Why XCode?

Freight management systems are complex. Data flows through multiple services, transformations happen at every step, and a single error can cascade into major operational issues. **XCode** gives you confidence that your freight data is correct, consistent, and complete.

### The Problem We Solve

- **❌ Manual Testing is Slow**: Testing freight workflows manually is time-consuming and error-prone
- **❌ Data Inconsistencies**: Freight data often becomes inconsistent across systems
- **❌ No Regression Testing**: Changes break existing functionality without warning
- **❌ Limited Visibility**: Hard to know if your freight data is valid until it's too late

### Our Solution

- **✅ Automated Validation**: Define rules once, validate automatically
- **✅ Scenario Testing**: Test complex multi-step workflows easily
- **✅ Continuous Monitoring**: Catch issues before they reach production
- **✅ Multi-System Support**: Works with WowFreight, Reflexia, and TrackBox

---

## ✨ Key Features

### 🔍 **Validation Engine**
Define business rules (invariants) and validate freight data automatically.

### 🎭 **Scenario Testing**
Test complex workflows with easy-to-read YAML scenarios.

### 🔌 **Multi-System Adapters**
Connect to multiple freight systems with consistent APIs:
- HTTP Adapter (live API calls)
- Mock Adapter (fast testing)
- Record/Replay Adapter (capture & replay)

### 📊 **Reporting Dashboard**
Beautiful visualizations of validation results with pass/fail rates and metrics.

### 🚀 **CI/CD Integration**
Run validations in your pipeline with GitHub Actions, GitLab CI, Jenkins, etc.

---

## ⚡ Quick Start

Get up and running in 5 minutes:

\`\`\`bash
# 1. Clone and setup
git clone https://github.com/yourorg/xcode.git
cd xcode
npm install

# 2. Run validations
npm run validate

# 3. View progress
xtask-stats
\`\`\`

---

## 📦 Installation

### Prerequisites

- Node.js 18+
- npm 8+ or yarn
- Git 2.0+

### Standard Installation

\`\`\`bash
git clone https://github.com/yourorg/xcode.git
cd xcode
npm install
npm run validate
\`\`\`

### Verify Installation

\`\`\`bash
# Check tools are available
xtask-quick list
xtask-stats
xcodebox --version
\`\`\`

---

## 🎯 Usage

### Basic Validation

\`\`\`bash
# Validate a shipment
xcodebox validate --shipment-id SHP-12345

# Validate date range
xcodebox validate --from 2025-01-01 --to 2025-01-31

# Run specific suite
xcodebox validate --suite wowfreight-critical
\`\`\`

### Running Scenarios

\`\`\`bash
# Run single scenario
xcodebox scenario run scenarios/create-shipment.yaml

# Run all scenarios
xcodebox scenario run-all scenarios/wowfreight/

# Run with custom data
xcodebox scenario run scenarios/quote.yaml --data '{"weight": 5000}'
\`\`\`

### Generating Reports

\`\`\`bash
# HTML report
xcodebox report generate --format html --output report.html

# JSON for CI/CD
xcodebox report generate --format json --output results.json

# Interactive dashboard
xcodebox report view
\`\`\`

---

## 📁 Project Structure

\`\`\`
xcode/
├── packages/           # Monorepo packages
│   ├── core/          # Core validation engine
│   ├── adapters/      # API adapters
│   └── cli/           # CLI tools
├── roadmaps/          # Project roadmap
│   └── generated/
│       └── tasks/     # 75 structured tasks
├── invariants/        # Business rules
│   └── wowfreight/   # WowFreight-specific
├── scenarios/         # Test scenarios
│   └── wowfreight/   # WowFreight workflows
├── reports/           # Generated reports
├── tests/             # Test suites
├── docs/              # Documentation
└── README.md          # This file
\`\`\`

---

## 📊 Task Management

XCode uses a structured 75-task roadmap across 13 epics.

### View Tasks

\`\`\`bash
# List all tasks
xtask-quick list

# Show task details
xtask-quick show T015

# Get AI prompt
xtask-quick prompt T015 planning
\`\`\`

### Track Progress

\`\`\`bash
# Mark task complete
xtask-complete T002 "Enhanced README complete"

# View dashboard
xtask-stats

# List completed
xtask-complete --list
\`\`\`

### Epic Breakdown

| Epic | Description | Tasks | Status |
|------|-------------|-------|--------|
| **E01** | Scaffold & Tooling | T001-T006 | ⏳ In Progress |
| **E02** | Proot & Sync | T007-T010 | ⏹️ Pending |
| **E03** | API Adapters | T011-T014 | ⏹️ Pending |
| **E04** | Validation Engine | T015-T020 | ⏹️ Pending |
| **E05** | WowFreight Invariants | T021-T070 | ⏹️ Pending |
| **E06** | Scenario Testing | T027-T071 | ⏹️ Pending |
| **E07** | CI/CD Integration | T032-T073 | ⏹️ Pending |
| **E08** | Reporting Dashboard | T037-T072 | ⏹️ Pending |
| **E09** | Developer Tools | T041-T074 | ⏹️ Pending |
| **E10** | Security & Compliance | T045-T075 | ⏹️ Pending |
| **E11** | Reflexia Integration | T049-T053 | ⏹️ Pending |
| **E12** | TrackBox Integration | T054-T058 | ⏹️ Pending |
| **E13** | Documentation & Rollout | T059-T069 | ⏹️ Pending |

---

## 💻 Development

### Running Locally

\`\`\`bash
npm run dev          # Development mode
npm run lint         # Check code quality
npm run format       # Format code
npm test             # Run tests
\`\`\`

### Creating Invariants

\`\`\`javascript
// invariants/wowfreight/weight-validation.js
module.exports = {
  id: 'wf-weight-001',
  name: 'Valid Shipment Weight',
  validate: (shipment) => {
    if (shipment.weight <= 0) {
      return { valid: false, error: 'Weight must be positive' };
    }
    if (shipment.weight > 50000) {
      return { valid: false, error: 'Weight exceeds maximum' };
    }
    return { valid: true };
  }
};
\`\`\`

### Creating Scenarios

\`\`\`yaml
# scenarios/create-shipment.yaml
name: Create Shipment Flow
steps:
  - action: POST /shipments
    data:
      origin: "LAX"
      destination: "JFK"
      weight: 1500
    expect:
      status: 201
      body:
        status: "created"
\`\`\`

---

## 🤝 Contributing

We welcome contributions! Here's how:

1. **Fork** the repository
2. **Create** feature branch (\`git checkout -b feature/amazing\`)
3. **Commit** changes (\`git commit -m 'Add feature'\`)
4. **Push** to branch (\`git push origin feature/amazing\`)
5. **Open** Pull Request

### Code Standards

- ESLint for linting
- Prettier for formatting
- 80%+ test coverage
- Conventional commits

### Workflow

\`\`\`bash
# 1. Pick a task
xtask-quick show T015

# 2. Get guidance
xtask-quick prompt T015 planning

# 3. Create branch
git checkout -b feature/T015-validation

# 4. Implement & test
npm test

# 5. Commit
git commit -m "T015: Implement validation engine"

# 6. Mark complete
xtask-complete T015 "Validation engine complete"
\`\`\`

---

## 🧪 Testing

\`\`\`bash
# Run all tests
npm test

# Watch mode
npm run test:watch

# Coverage
npm run test:coverage

# Specific tests
npm test -- tests/unit/engine.test.js
\`\`\`

---

## 🔧 Troubleshooting

### Common Issues

**Module not found**
\`\`\`bash
rm -rf node_modules package-lock.json
npm install
\`\`\`

**API authentication failed**
\`\`\`bash
export WOWFREIGHT_API_KEY="your-key-here"
\`\`\`

**Tests failing**
\`\`\`bash
node --version  # Should be 18+
npm --version   # Should be 8+
\`\`\`

### Debug Mode

\`\`\`bash
export DEBUG=xcode:*
xcodebox validate --verbose
\`\`\`

### Getting Help

- 📖 Documentation: Check \`docs/\` directory
- 💬 Discussions: GitHub Discussions
- 🐛 Bug Reports: GitHub Issues
- 📧 Email: support@yourorg.com

---

## 🗺️ Roadmap

### Completed ✅
- [x] Project scaffolding (T001)
- [x] Enhanced README (T002)
- [x] Task management system

### In Progress ⏳
- [ ] Validation engine (E04)
- [ ] API adapters (E03)

### Planned 📋
- [ ] Scenario testing (E06)
- [ ] CI/CD integration (E07)
- [ ] Reporting dashboard (E08)
- [ ] Reflexia integration (E11)
- [ ] TrackBox integration (E12)

---

## 📄 License

This project is licensed under the MIT License - see LICENSE file for details.

---

## 🙏 Acknowledgments

- Thanks to all contributors
- Built with ❤️ for better freight validation
- Inspired by the need for data quality in logistics

---

## 📞 Contact

- **Website**: https://xcode.yourorg.com
- **Email**: team@yourorg.com
- **Issues**: https://github.com/yourorg/xcode/issues

---

<div align="center">

**[⬆ Back to Top](#xcode-quality-framework)**

Made with ❤️ for better freight validation

</div>

XCODEBOX HOTPATCH V3.4.1
------------------------------------------------------------
PURPOSE: RESTORE XCODEBOX TO ITS ORIGINAL IDENTITY

XCodeBox was originally designed as a Code Scanner and Discovery Tool for the Reflexia Ecosystem — not a freight validation framework. 
This hotpatch restores XCodeBox to its true purpose: scanning codebases (both local Termux projects and GitHub repositories) to discover, analyze, and enhance code quality.

------------------------------------------------------------
HISTORY: WHAT HAPPENED

Original Vision (Reflexia Ecosystem):
XCodeBox = Code Scanner & Discovery Tool
 ├── Scan Termux for abandoned/existing code
 ├── Scan GitHub repositories
 ├── Discover project structures
 ├── Analyze code quality
 └── Integrate with Reflexia, TrackBox, WowFreight

What Went Wrong:
During development, XCodeBox documentation was mixed with freight validation frameworks, causing confusion about its purpose.

This Hotpatch:
Restores XCodeBox to its original code scanning functionality with a modern plugin architecture.

------------------------------------------------------------
ARCHITECTURE

XCodeBox v3.4.1
 ├── HookBus (Event-Driven Plugin System)
 │   ├── preScan   - Resolve targets (local/GitHub)
 │   ├── scan      - Discover code structures
 │   ├── enrich    - Add metadata/analysis
 │   ├── report    - Generate reports
 │   ├── integrate - Push to external systems
 │   └── post      - Cleanup/telemetry
 │
 ├── Core Plugins
 │   ├── local-fs.js      - Scan local filesystem
 │   ├── github-fetch.js  - Clone/fetch GitHub repos
 │   └── xdiscover.js     - Code discovery engine
 │
 ├── CLI Interface
 │   ├── xcode-hooks.js   - Main CLI entry
 │   └── bin/xcode        - Binary wrapper
 │
 └── Tools
     └── doctor.sh        - Environment diagnostics

------------------------------------------------------------
PLUGIN SYSTEM

XCodeBox uses a hook-based plugin architecture.

Hook Lifecycle:
1. preScan   → Resolve target (local path or GitHub URL)
2. scan      → Discover code, dependencies, structure
3. enrich    → Add analysis, metrics, insights
4. report    → Generate reports, summaries
5. integrate → Push to Reflexia/TrackBox/etc.
6. post      → Cleanup, telemetry

Example Plugin:
module.exports = {
  name: 'security-scan',
  supports: ['enrich'],
  async run(hook, ctx) {
    if (hook !== 'enrich') return ctx;
    const vulnerabilities = await scanForVulnerabilities(ctx.resolved.path);
    ctx.security = vulnerabilities;
    return ctx;
  }
};

------------------------------------------------------------
USAGE

Basic Scanning:
source ~/.proot_aliases_xcode
xhook hook:run --target /root/xcode
xhook hook:run --target github:rocketlang/reflexia
xhook hook:run --target . --steps preScan,scan

Using Aliases:
xhook_local      # Scan /root/xcode
xhook_reflexia   # Scan /root/reflexia
xhook_gh         # Scan github:rocketlang/reflexia

Custom Scanning:
xhook hook:run --target /root/my-project
xhook hook:run --target github:rocketlang/reflexia@develop
xhook hook:run --target . --steps scan

------------------------------------------------------------
ENVIRONMENT SETUP

Check Environment:
bash /root/xcode/xcode-tools/doctor.sh check

Requirements:
- Node.js ≥ 18
- Git
- npm
- Optional: jq, curl
- Optional: gitleaks, semgrep (for security scanning)

------------------------------------------------------------
INTEGRATION WITH REFLEXIA ECOSYSTEM

1. Reflexia (Core)
   - Scans Reflexia codebase
   - Discovers components
   - Analyzes architecture

2. TrackBox (Project Management)
   - Scans project repositories
   - Tracks code changes
   - Finds abandoned projects

3. WowFreight (Freight Management)
   - Scans freight-related code
   - Validates data models
   - Checks API integrations

4. XCode Suite (75-Task Framework)
   - Enhances XCodeBox with validation, rules, and scenario testing

------------------------------------------------------------
WHAT GETS SCANNED

- File Structure: Directories and organization
- Dependencies: package.json, requirements.txt
- Code Metrics: LOC, complexity, patterns
- Git History: Commits, contributors, activity
- Documentation: READMEs, comments, docs
- Configuration: Config files, env vars
- Security: Vulnerabilities (if plugins enabled)
- Quality: Linting issues and code smells

------------------------------------------------------------
FUTURE ENHANCEMENTS (75-TASK FRAMEWORK)

Epic E03: API Adapters
  - Adapters for WowFreight, Reflexia, TrackBox
  - Enable direct API scanning

Epic E04: Validation Engine
  - Business rule validation
  - Data consistency checks

Epic E05–E08: Domain-Specific Scanners
  - WowFreight invariants
  - Reflexia architecture checks
  - TrackBox validation

Epic E09: Developer Tools
  - IDE integration
  - VS Code extensions
  - Real-time scanning

------------------------------------------------------------
PLUGIN DEVELOPMENT

Adding Custom Plugins:
Create file in xcodebox.plugins/

Example:
module.exports = {
  name: 'my-scanner',
  supports: ['scan', 'enrich'],
  async run(hook, ctx) {
    if (hook === 'scan') console.log(`Scanning ${ctx.resolved.path}`);
    if (hook === 'enrich') ctx.myData = { analyzed: true };
    return ctx;
  }
};

Best Practices:
- Always return ctx
- Add errors to ctx.errors
- Use ctx.resolved.path
- Check hook before processing
- Handle nulls defensively

------------------------------------------------------------
TROUBLESHOOTING

"No target resolved"
  - Verify path or GitHub URL
  - Check network connection

"Node >=18 required"
  node -v
  curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
  apt-get install -y nodejs

"xdiscover_enhanced.mjs not found"
  - Plugin optional, scanning still works

"Plugins not loading"
  ls -la /root/xcode/xcodebox.plugins/
  xhook hook:run --target . | grep registry

------------------------------------------------------------
FILE STRUCTURE

/root/xcode/xcodesuite-mono-v1.1/
 └── packages/xcodebox-core/
     ├── bin/xcode
     ├── src/core/
     │   ├── hookbus.js
     │   └── registry.js
     ├── src/plugins/
     │   ├── local-fs.js
     │   ├── github-fetch.js
     │   └── xdiscover.js
     └── src/cli/xcode-hooks.js

/root/xcode/xcode-tools/doctor.sh
/root/.proot_aliases_xcode
/root/xcode/xcodebox.plugins/ (user-created plugins)

------------------------------------------------------------
SUCCESS CRITERIA

You should be able to:
- Run xhook hook:run --target . without errors
- Scan local Termux projects
- Clone and scan GitHub repositories
- See plugin load logs
- Access CLI via xhook alias
- Run diagnostics with doctor.sh

------------------------------------------------------------
RELATED DOCUMENTATION

- README.md                → Overall project overview
- PROJECT_REPORT.md         → Progress and decisions
- roadmaps/                 → 75-task detailed breakdown
- tests/README.md           → Testing documentation

------------------------------------------------------------
SUPPORT

For help:
- Run doctor.sh
- Check plugin logs
- Review main README
- GitHub Issues: https://github.com/rocketlang/xcode-suite

------------------------------------------------------------
XCodeBox v3.4.1 - Code Scanner & Discovery Tool for Reflexia Ecosystem
MOTTO: Break When We Die
------------------------------------------------------------
---

# ✅ XCodeBox Hotpatch v3.4.1 – Post-Install Verification (Termux/Proot)

This section documents the successful verification of XCodeBox Hotpatch v3.4.1  
on a Termux + proot-Ubuntu environment.

## 🧩 Environment Summary
| Component | Status | Notes |
|------------|---------|-------|
| Node.js | ✅ v20.17.0 | Meets >=18 requirement |
| npm | ✅ Installed | Used for `js-yaml` |
| git | ✅ Installed | For GitHub fetch plugin |
| jq / curl | ✅ Installed | Utility support |
| js-yaml | ✅ Installed | Dependency for registry |
| Suite Path | `/root/xcode/xcodesuite-mono-v1.1/packages/xcodebox-core` | Verified |
| CLI Path | `/root/xcode/xcodesuite-mono-v1.1/packages/xcodebox-core/src/cli/xcode-hooks.js` | Verified |
| Bin Path | `/root/xcode/xcodesuite-mono-v1.1/packages/xcodebox-core/bin/xcode` | Verified |

---

## 🧠 Verification Commands

### 1️⃣  Doctor Check
```bash
bash /root/xcode/xcode-tools/doctor.sh check
```
Expected output:
```
OK Node >=18 (v20.17.0)
OK npm found
OK git found
OK jq found
OK curl found
OK Suite directory exists
OK CLI executable
Doctor check complete.
```

### 2️⃣  Local Scan Test
```bash
xhook hook:run --target .
```
Expected output:
```
[xcodebox:registry] Loaded plugin: local-fs
[xcodebox:registry] Loaded plugin: github-fetch
[xcodebox:registry] Loaded plugin: xdiscover
[xcodebox:hook] preScan -> local-fs
[xcodebox:hook] scan -> xdiscover
[xcodebox] Done. Artifacts: {}
```
✔ Indicates the CLI, HookBus, and plugin system are working correctly.

---

## ⚙️ Usage Quick Reference
```bash
source ~/.proot_aliases_xcode     # Load aliases into current shell
xhook hook:run --target .         # Scan current directory
xhook_reflexia                    # Scan Reflexia project
bash /root/xcode/xcode-tools/doctor.sh check   # Environment check
```

---

## 📁 Verified Structure
```
xcodesuite-mono-v1.1/
└── packages/
    └── xcodebox-core/
        ├── bin/
        │   └── xcode
        ├── src/
        │   ├── core/
        │   │   ├── hookbus.js
        │   │   └── registry.js
        │   ├── plugins/
        │   │   ├── local-fs.js
        │   │   ├── github-fetch.js
        │   │   └── xdiscover.js
        │   └── cli/
        │       └── xcode-hooks.js
        └── node_modules/js-yaml/
```

---

## 🧾 Verification Result
- ✅ Installation successful on Termux/proot Ubuntu
- ✅ All modules and CLI paths verified
- ✅ js-yaml dependency installed
- ✅ Local scan executed successfully  
- ✅ `xhook` alias operational  

---

**Status:** *Operational*  
**Verified on:** October 18 2025  
**Verified by:** Reflexia / XCode Development Team  

> “Break when we die — because it’s finally alive.” 🔥

## Documentation
- [Deep Usage Guide](docs/DEEP_USAGE_GUIDE.md)
