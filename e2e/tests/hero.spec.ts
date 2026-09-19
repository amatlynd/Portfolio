import { test, expect } from '@playwright/test';

test.beforeEach(async ({ page }) => {
  await page.goto('/');
});

test('shows name, tagline and status badge', async ({ page }) => {
  await expect(page.locator('.hero-name')).toHaveText('Lyndon Amat');
  await expect(page.locator('.hero-tagline')).toContainText('I build for mobile');
  await expect(page.locator('.hero-status')).toContainText('Open to opportunities');
});

test('shows the lede description', async ({ page }) => {
  await expect(page.locator('.hero-lede')).toContainText('Software developer in Toronto');
});

test('contact links point to the right places', async ({ page }) => {
  const links = page.locator('.hero-links .hero-link');
  await expect(links.filter({ hasText: 'GitHub' })).toHaveAttribute('href', /github\.com/);
  await expect(links.filter({ hasText: 'LinkedIn' })).toHaveAttribute('href', /linkedin\.com/);
  await expect(page.locator('a.hero-link[href^="mailto:"]')).toHaveAttribute(
    'href',
    'mailto:lyndon.amat@gmail.com'
  );
});

test('wordmark links home', async ({ page }) => {
  await expect(page.locator('.wordmark')).toHaveAttribute('href', '/');
});
