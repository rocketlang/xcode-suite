# XCode Quality Framework

A comprehensive validation and testing framework for freight management systems (WowFreight, Reflexia, TrackBox).

## 🚀 Quick Start

```bash
# Install dependencies
npm install

# Run validation
npm run validate

# Lint code
npm run lint

# Format code
npm run format

# Run tests
npm test
```

## 📁 Project Structure

```
xcode/
├── packages/              # Workspace packages
│   ├── core/             # Core validation engine
│   ├── adapters/         # API adapters (HTTP, Mock, Record/Replay)
│   └── cli/              # CLI tools (xcode, xcodebox)
├── roadmaps/             # Project roadmaps and tasks
│   └── generated/
│       └── tasks/        # 75 structured tasks
├── reports/              # Validation reports
├── docs/                 # Documentation
└── tests/                # Test suites

```

## 🎯 Key Features

- **Validation Engine**: Define and run invariants against freight data
- **Scenario Testing**: Test complex workflows and edge cases
- **API Adapters**: Connect to multiple freight management systems
- **CI/CD Integration**: Automated validation in your pipeline
- **Reporting Dashboard**: Visualize validation results

## 🔧 Development

### Linting
```bash
npm run lint          # Check for issues
npm run lint:fix      # Auto-fix issues
```

### Formatting
```bash
npm run format        # Format all files
npm run format:check  # Check formatting
```

### Testing
```bash
npm test              # Run test suite
npm run test:watch    # Run tests in watch mode
```

## 📊 Task Management

This project uses XPlan for task management:

```bash
# List all tasks
xtask-quick list

# View task details
xtask-quick show T001

# Get AI prompt for task
xtask-quick prompt T001 planning
```

## 🏗️ Epics

1. **E01**: Scaffold & Tooling (T001-T006)
2. **E02**: Proot & Sync (T007-T010)
3. **E03**: API Adapters (T011-T014)
4. **E04**: Validation Engine (T015-T020)
5. **E05**: WowFreight Invariants (T021-T026, T070)
6. **E06**: Scenario Testing (T027-T031, T071)
7. **E07**: CI/CD Integration (T032-T036, T073)
8. **E08**: Reporting Dashboard (T037-T040, T072)
9. **E09**: Developer Tools (T041-T044, T074)
10. **E10**: Security & Compliance (T045-T048, T075)
11. **E11**: Reflexia Integration (T049-T053)
12. **E12**: TrackBox Integration (T054-T058)
13. **E13**: Documentation & Rollout (T059-T069)

## 📝 Contributing

1. Pick a task: `xtask-quick list`
2. Get the prompt: `xtask-quick prompt T001 planning`
3. Create a feature branch: `git checkout -b feature/T001`
4. Make your changes
5. Run validation: `npm run validate`
6. Commit: `git commit -m "T001: Initialize scaffold"`
7. Push and create PR

## 📄 License

MIT

## 🤝 Team

XCode Development Team

---

**Built with ❤️ for better freight validation**
