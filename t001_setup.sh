#!/usr/bin/env bash
# T001: Scaffold & Tooling - Automated Setup
# This script sets up the complete development environment for XCode framework

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${BOLD}${CYAN}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}${CYAN}║  T001: Scaffold & Tooling - Automated Setup             ║${NC}"
echo -e "${BOLD}${CYAN}╚══════════════════════════════════════════════════════════╝${NC}"
echo ""

# Configuration
PROJECT_ROOT="${PROJECT_ROOT:-/root/xcode}"
BACKUP_DIR="/root/xcode_backup_$(date +%Y%m%d_%H%M%S)"

echo -e "${CYAN}📂 Project Root: ${PROJECT_ROOT}${NC}"
echo -e "${CYAN}💾 Backup Location: ${BACKUP_DIR}${NC}"
echo ""

# Step 1: Backup existing files
echo -e "${BOLD}${CYAN}[Step 1/10] Creating backup...${NC}"
if [ -d "$PROJECT_ROOT" ]; then
    echo -e "${YELLOW}⚠️  Project directory exists, creating backup...${NC}"
    mkdir -p "$BACKUP_DIR"
    
    # Backup only config files that we'll be creating
    for file in .gitignore package.json .eslintrc.json .prettierrc README.md; do
        if [ -f "$PROJECT_ROOT/$file" ]; then
            cp "$PROJECT_ROOT/$file" "$BACKUP_DIR/" 2>/dev/null || true
            echo "  📦 Backed up: $file"
        fi
    done
    echo -e "${GREEN}✅ Backup created at: ${BACKUP_DIR}${NC}"
else
    echo -e "${GREEN}✅ Fresh installation, no backup needed${NC}"
fi
echo ""

# Step 2: Create project structure
echo -e "${BOLD}${CYAN}[Step 2/10] Creating project structure...${NC}"
cd "$PROJECT_ROOT"

# Create directory structure (preserve existing if present)
mkdir -p packages/{core,adapters,cli}
mkdir -p tests
mkdir -p docs
mkdir -p reports/.gitkeep

echo -e "${GREEN}✅ Project structure created${NC}"
echo ""

# Step 3: Initialize Git (if not already)
echo -e "${BOLD}${CYAN}[Step 3/10] Initializing Git repository...${NC}"
if [ ! -d .git ]; then
    git init
    git config user.name "${GIT_USER_NAME:-XCode Developer}"
    git config user.email "${GIT_USER_EMAIL:-dev@xcode.local}"
    echo -e "${GREEN}✅ Git initialized${NC}"
else
    echo -e "${YELLOW}⚠️  Git already initialized, skipping...${NC}"
fi
echo ""

# Step 4: Create .gitignore
echo -e "${BOLD}${CYAN}[Step 4/10] Creating .gitignore...${NC}"
cat > .gitignore << 'EOF'
# Dependencies
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
package-lock.json
yarn.lock

# Environment
.env
.env.local
.env.*.local
*.key
*.pem

# IDE
.vscode/
.idea/
*.swp
*.swo
*~
.DS_Store

# Build output
dist/
build/
*.log
coverage/
.nyc_output/

# Reports (keep structure, ignore content)
reports/*.html
reports/*.json
!reports/.gitkeep

# Temporary files
tmp/
temp/
*.tmp
.cache/

# OS
Thumbs.db
.Spotlight-V100
.Trashes
EOF

echo -e "${GREEN}✅ .gitignore created${NC}"
echo ""

# Step 5: Create package.json
echo -e "${BOLD}${CYAN}[Step 5/10] Creating package.json...${NC}"
cat > package.json << 'EOF'
{
  "name": "xcode-framework",
  "version": "1.0.0",
  "description": "XCode Quality Framework - Validation and Testing for Freight Systems",
  "private": true,
  "workspaces": [
    "packages/*"
  ],
  "scripts": {
    "lint": "eslint . --ext .js,.ts --ignore-path .gitignore",
    "lint:fix": "eslint . --ext .js,.ts --fix --ignore-path .gitignore",
    "format": "prettier --write '**/*.{js,ts,json,md,yaml,yml}'",
    "format:check": "prettier --check '**/*.{js,ts,json,md,yaml,yml}'",
    "test": "echo 'Test suite coming in T014' && exit 0",
    "validate": "npm run lint && npm run format:check",
    "prepare": "command -v husky >/dev/null 2>&1 && husky install || echo 'Husky not installed yet'"
  },
  "keywords": [
    "validation",
    "quality",
    "testing",
    "freight",
    "logistics"
  ],
  "author": "XCode Team",
  "license": "MIT",
  "engines": {
    "node": ">=16.0.0",
    "npm": ">=8.0.0"
  },
  "devDependencies": {
    "eslint": "^8.50.0",
    "prettier": "^3.0.3",
    "husky": "^8.0.3",
    "lint-staged": "^14.0.1"
  }
}
EOF

echo -e "${GREEN}✅ package.json created${NC}"
echo ""

# Step 6: Create ESLint configuration
echo -e "${BOLD}${CYAN}[Step 6/10] Creating ESLint configuration...${NC}"
cat > .eslintrc.json << 'EOF'
{
  "env": {
    "node": true,
    "es2022": true,
    "mocha": true
  },
  "extends": ["eslint:recommended"],
  "parserOptions": {
    "ecmaVersion": 2022,
    "sourceType": "module"
  },
  "rules": {
    "no-console": ["warn", { "allow": ["warn", "error"] }],
    "no-unused-vars": ["error", { 
      "argsIgnorePattern": "^_",
      "varsIgnorePattern": "^_"
    }],
    "prefer-const": "error",
    "no-var": "error",
    "eqeqeq": ["error", "always"],
    "curly": ["error", "all"],
    "brace-style": ["error", "1tbs"],
    "indent": ["error", 2, { "SwitchCase": 1 }],
    "quotes": ["error", "single", { "avoidEscape": true }],
    "semi": ["error", "always"]
  },
  "ignorePatterns": [
    "node_modules/",
    "dist/",
    "build/",
    "coverage/"
  ]
}
EOF

echo -e "${GREEN}✅ ESLint configuration created${NC}"
echo ""

# Step 7: Create Prettier configuration
echo -e "${BOLD}${CYAN}[Step 7/10] Creating Prettier configuration...${NC}"
cat > .prettierrc << 'EOF'
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 100,
  "tabWidth": 2,
  "useTabs": false,
  "arrowParens": "always",
  "endOfLine": "lf"
}
EOF

cat > .prettierignore << 'EOF'
node_modules
dist
build
coverage
*.log
package-lock.json
yarn.lock
EOF

echo -e "${GREEN}✅ Prettier configuration created${NC}"
echo ""

# Step 8: Create comprehensive README
echo -e "${BOLD}${CYAN}[Step 8/10] Creating README.md...${NC}"
cat > README.md << 'EOF'
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
EOF

echo -e "${GREEN}✅ README.md created${NC}"
echo ""

# Step 9: Create initial test
echo -e "${BOLD}${CYAN}[Step 9/10] Creating initial tests...${NC}"
mkdir -p tests

cat > tests/scaffold.test.js << 'EOF'
/**
 * T001 Scaffold Tests
 * Validates that the project structure is properly set up
 */

const assert = require('assert');
const fs = require('fs');
const path = require('path');

describe('T001: Scaffold & Tooling', () => {
  const projectRoot = path.resolve(__dirname, '..');

  describe('Configuration Files', () => {
    it('should have package.json', () => {
      const pkgPath = path.join(projectRoot, 'package.json');
      assert.ok(fs.existsSync(pkgPath), 'package.json should exist');
      
      const pkg = require(pkgPath);
      assert.ok(pkg.name, 'package.json should have name');
      assert.ok(pkg.version, 'package.json should have version');
      assert.ok(pkg.workspaces, 'package.json should have workspaces');
    });

    it('should have .gitignore', () => {
      const gitignorePath = path.join(projectRoot, '.gitignore');
      assert.ok(fs.existsSync(gitignorePath), '.gitignore should exist');
    });

    it('should have ESLint config', () => {
      const eslintPath = path.join(projectRoot, '.eslintrc.json');
      assert.ok(fs.existsSync(eslintPath), '.eslintrc.json should exist');
    });

    it('should have Prettier config', () => {
      const prettierPath = path.join(projectRoot, '.prettierrc');
      assert.ok(fs.existsSync(prettierPath), '.prettierrc should exist');
    });

    it('should have README', () => {
      const readmePath = path.join(projectRoot, 'README.md');
      assert.ok(fs.existsSync(readmePath), 'README.md should exist');
    });
  });

  describe('Directory Structure', () => {
    it('should have packages directory', () => {
      const packagesPath = path.join(projectRoot, 'packages');
      assert.ok(fs.existsSync(packagesPath), 'packages/ should exist');
    });

    it('should have tests directory', () => {
      const testsPath = path.join(projectRoot, 'tests');
      assert.ok(fs.existsSync(testsPath), 'tests/ should exist');
    });

    it('should have reports directory', () => {
      const reportsPath = path.join(projectRoot, 'reports');
      assert.ok(fs.existsSync(reportsPath), 'reports/ should exist');
    });
  });

  describe('Git Repository', () => {
    it('should have .git directory', () => {
      const gitPath = path.join(projectRoot, '.git');
      assert.ok(fs.existsSync(gitPath), '.git/ should exist');
    });
  });
});
EOF

echo -e "${GREEN}✅ Initial tests created${NC}"
echo ""

# Step 10: Git commit all changes
echo -e "${BOLD}${CYAN}[Step 10/10] Committing changes to Git...${NC}"

# Stage all new files
git add .gitignore package.json .eslintrc.json .prettierrc .prettierignore README.md tests/

# Commit
if git diff --cached --quiet; then
    echo -e "${YELLOW}⚠️  No changes to commit${NC}"
else
    git commit -m "T001: Initialize scaffold and tooling

- Add .gitignore with comprehensive exclusions
- Add package.json with workspace configuration
- Add ESLint and Prettier configurations
- Add comprehensive README
- Add initial test suite
- Create project directory structure

This completes Epic E01, Task T001"
    echo -e "${GREEN}✅ Changes committed to Git${NC}"
fi
echo ""

# Final summary
echo -e "${BOLD}${GREEN}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${BOLD}${GREEN}║            ✅ T001 Setup Complete!                       ║${NC}"
echo -e "${BOLD}${GREEN}╚══════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${CYAN}📦 What was created:${NC}"
echo "  ✅ Git repository initialized"
echo "  ✅ .gitignore (comprehensive exclusions)"
echo "  ✅ package.json (workspace configuration)"
echo "  ✅ .eslintrc.json (linting rules)"
echo "  ✅ .prettierrc (formatting rules)"
echo "  ✅ README.md (project documentation)"
echo "  ✅ tests/scaffold.test.js (validation tests)"
echo "  ✅ Project structure (packages/, tests/, reports/)"
echo ""
echo -e "${CYAN}🚀 Next Steps:${NC}"
echo "  1. Install dependencies:"
echo -e "     ${YELLOW}cd $PROJECT_ROOT && npm install${NC}"
echo ""
echo "  2. Verify setup:"
echo -e "     ${YELLOW}npm run validate${NC}"
echo ""
echo "  3. Move to next task:"
echo -e "     ${YELLOW}xtask-quick show T002${NC}"
echo ""
echo -e "${CYAN}📊 Status:${NC}"
echo "  Epic: E01 (Scaffold & Tooling)"
echo "  Task: T001 - COMPLETE ✅"
echo "  Time: ~15 minutes"
echo "  Next: T002 (Add README.md enhancements)"
echo ""
echo -e "${BOLD}${GREEN}Ready to continue! 🎉${NC}"
