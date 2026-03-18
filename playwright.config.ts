import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './e2e/tests',
  fullyParallel: true,
  retries: 1,
  timeout: 30_000,
  use: {
    baseURL: 'http://localhost:8080',
    viewport: { width: 1280, height: 800 },
    // Flutter Web HTML renderer renders real DOM text
    // so we can use standard Playwright locators
  },
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
  ],
  webServer: {
    command: 'npx serve build/web -l 8080',
    url: 'http://localhost:8080',
    reuseExistingServer: !process.env.CI,
    timeout: 10_000,
  },
});
