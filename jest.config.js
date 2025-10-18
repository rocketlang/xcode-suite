module.exports = {
  testEnvironment: 'node',
  collectCoverage: false,
  coverageDirectory: 'coverage',
  coverageThreshold: {
    global: { branches: 80, functions: 80, lines: 80, statements: 80 }
  },
  testMatch: ['**/tests/**/*.test.js', '**/tests/**/*.spec.js'],
  setupFilesAfterEnv: ['<rootDir>/tests/setup.js'],
  verbose: true,
  clearMocks: true,
  testTimeout: 10000
};
