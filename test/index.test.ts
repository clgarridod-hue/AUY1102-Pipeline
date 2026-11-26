import { getConfiguredEndpoint } from '../src/index';

describe('Application Entrypoint', () => {
  it('should return the default configured endpoint', () => {
    expect(getConfiguredEndpoint()).toBe('https://api.example.com/data');
  });

  it('should return a custom endpoint when provided', () => {
    expect(getConfiguredEndpoint('https://api.duoc.cl/health')).toBe(
      'https://api.duoc.cl/health'
    );
  });
});
