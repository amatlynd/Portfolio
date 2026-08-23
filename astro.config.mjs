import { defineConfig } from 'astro/config';

export default defineConfig({
  site: 'https://lyndonamat.com',
  trailingSlash: 'ignore',
  build: { inlineStylesheets: 'always' },
  compressHTML: true,
});
