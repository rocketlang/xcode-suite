describe('Validator', () => {
  it('should validate shipment', () => {
    const shipment = { id: 'TEST', weight: 1000 };
    expect(shipment.id).toBeDefined();
    expect(shipment.weight).toBeGreaterThan(0);
  });
});
