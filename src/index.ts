export * from './value-object';

export function getConfiguredEndpoint(
  baseUrl = 'https://api.example.com/data'
): string {
  return baseUrl;
}
