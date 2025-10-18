// Global test setup
// Runs before all tests

// Set test environment variables
process.env.NODE_ENV = 'test';
process.env.LOG_LEVEL = 'error';

// Global test timeout
jest.setTimeout(10000);

// Mock console methods to reduce noise in tests
global.console = {
  ...console,
  log: jest.fn(),
  debug: jest.fn(),
  info: jest.fn(),
  warn: jest.fn(),
  error: jest.fn(),
};

// Add custom matchers if needed
expect.extend({
  toBeValidShipment(received) {
    const pass = 
      received &&
      typeof received === 'object' &&
      received.id &&
      received.origin &&
      received.destination;
    
    if (pass) {
      return {
        message: () => `expected ${received} not to be a valid shipment`,
        pass: true,
      };
    } else {
      return {
        message: () => `expected ${received} to be a valid shipment`,
        pass: false,
      };
    }
  },
});

console.log('🧪 Test environment initialized');
