// Test utility functions

/**
 * Wait for a promise to resolve or reject
 */
async function waitFor(fn, timeout = 5000) {
  const startTime = Date.now();
  
  while (Date.now() - startTime < timeout) {
    try {
      const result = await fn();
      if (result) return result;
    } catch (e) {
      // Continue waiting
    }
    await sleep(100);
  }
  
  throw new Error(`Timeout waiting for condition after ${timeout}ms`);
}

/**
 * Sleep for specified milliseconds
 */
function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

/**
 * Create a mock function with predefined responses
 */
function createMockFn(responses = []) {
  let callCount = 0;
  
  return jest.fn(() => {
    if (callCount < responses.length) {
      return responses[callCount++];
    }
    return responses[responses.length - 1];
  });
}

/**
 * Assert that a function throws a specific error
 */
async function expectToThrow(fn, errorMessage) {
  try {
    await fn();
    throw new Error('Expected function to throw but it did not');
  } catch (error) {
    if (errorMessage) {
      expect(error.message).toContain(errorMessage);
    }
  }
}

module.exports = {
  waitFor,
  sleep,
  createMockFn,
  expectToThrow
};
