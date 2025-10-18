# XCode Testing Guide

## Overview

Comprehensive testing infrastructure for the XCode quality framework.

## Test Structure

\`\`\`
tests/
├── unit/              # Unit tests (isolated components)
│   ├── core/         # Core engine tests
│   ├── adapters/     # Adapter tests
│   └── validators/   # Validator tests
├── integration/       # Integration tests (component interaction)
│   ├── scenarios/    # Scenario tests
│   └── workflows/    # Workflow tests
├── e2e/              # End-to-end tests (full system)
├── fixtures/         # Test data
├── helpers/          # Test utilities
│   ├── mockData.js  # Mock data
│   └── testUtils.js # Test helper functions
└── setup.js          # Global test setup
\`\`\`

## Running Tests

### All Tests
\`\`\`bash
npm test
\`\`\`

### Watch Mode
\`\`\`bash
npm run test:watch
\`\`\`

### With Coverage
\`\`\`bash
npm run test:coverage
\`\`\`

### Unit Tests Only
\`\`\`bash
npm run test:unit
\`\`\`

### Integration Tests Only
\`\`\`bash
npm run test:integration
\`\`\`

### Verbose Output
\`\`\`bash
npm run test:verbose
\`\`\`

## Writing Tests

### Unit Test Example

\`\`\`javascript
const { Validator } = require('../../../src/validator');

describe('Validator', () => {
  let validator;
  
  beforeEach(() => {
    validator = new Validator();
  });
  
  it('should validate correct data', () => {
    const result = validator.validate({ id: 'TEST' });
    expect(result).toBe(true);
  });
});
\`\`\`

### Integration Test Example

\`\`\`javascript
describe('Workflow Integration', () => {
  it('should complete full workflow', async () => {
    const result = await runWorkflow();
    expect(result.success).toBe(true);
  });
});
\`\`\`

## Test Coverage Goals

- **Overall**: 80%+
- **Critical paths**: 95%+
- **Edge cases**: Covered
- **Error scenarios**: Covered

## Best Practices

1. **Arrange-Act-Assert**: Structure tests clearly
2. **Descriptive names**: Test names should explain what's tested
3. **One assertion per test**: Keep tests focused
4. **Mock external dependencies**: Isolate unit tests
5. **Clean up**: Use afterEach to reset state

## Custom Matchers

### toBeValidShipment

\`\`\`javascript
expect(shipment).toBeValidShipment();
\`\`\`

## Debugging Tests

\`\`\`bash
# Run specific test file
npm test -- tests/unit/core/validator.test.js

# Run tests matching pattern
npm test -- --testNamePattern="should validate"

# Debug mode
node --inspect-brk node_modules/.bin/jest --runInBand
\`\`\`

## Coverage Reports

After running \`npm run test:coverage\`:
- View HTML report: \`open coverage/index.html\`
- Check console output for summary
- lcov format for CI/CD integration

## CI/CD Integration

Tests run automatically on:
- Pull requests
- Commits to main branch
- Pre-deployment

## Troubleshooting

### Tests timeout
Increase timeout in jest.config.js or per-test:
\`\`\`javascript
it('long test', async () => {
  // test code
}, 30000); // 30 second timeout
\`\`\`

### Mocks not working
Ensure mocks are cleared:
\`\`\`javascript
afterEach(() => {
  jest.clearAllMocks();
});
\`\`\`

### Coverage too low
Check coverage report to see uncovered lines:
\`\`\`bash
npm run test:coverage
open coverage/index.html
\`\`\`
