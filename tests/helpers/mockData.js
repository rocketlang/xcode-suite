// Mock data for tests

const mockShipment = {
  id: 'SHP-TEST-001',
  origin: 'Los Angeles, CA',
  destination: 'New York, NY',
  weight: 1500,
  dimensions: {
    length: 48,
    width: 40,
    height: 36
  },
  status: 'created',
  createdAt: '2025-10-18T00:00:00Z'
};

const mockInvalidShipment = {
  id: 'SHP-INVALID',
  weight: -100,
  // Missing required fields
};

const mockAPIResponse = {
  success: true,
  data: mockShipment,
  timestamp: '2025-10-18T00:00:00Z'
};

const mockAPIError = {
  success: false,
  error: {
    code: 'VALIDATION_ERROR',
    message: 'Invalid shipment data',
    details: ['Weight must be positive']
  }
};

module.exports = {
  mockShipment,
  mockInvalidShipment,
  mockAPIResponse,
  mockAPIError
};
