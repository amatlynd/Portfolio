import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './e2e/tests',
  fullyParallel: true,
  retries: process.env.CI ? 1 : 0,
  timeout: 30_000,
  reporter: process.env.CI ? [['list'], ['html', { open: 'never' }]] : 'list',
  use: {
    baseURL: 'http://localhost:4321',
    trace: 'retain-on-failure',
  },
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
  ],
  webServer: {
    command: 'npm run build && npm run preview -- --port 4321',
    url: 'http://localhost:4321',
    reuseExistingServer: !process.env.CI,
    timeout: 60_000,
  },
});
