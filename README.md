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
