import { test, expect } from '@playwright/test';

test.beforeEach(async ({ page }) => {
  await page.goto('/');
});

test('core meta tags are present and non-empty', async ({ page }) => {
  await expect(page).toHaveTitle('Lyndon Amat — Software Developer');
  expect(await page.locator('html').getAttribute('lang')).toBe('en');

  const description = await page.locator('meta[name="description"]').getAttribute('content');
  expect(description).toBeTruthy();
  expect(description!.length).toBeGreaterThan(20);

  await expect(page.locator('link[rel="canonical"]')).toHaveAttribute('href', 'https://lyndonamat.com/');
  await expect(page.locator('meta[name="robots"]')).toHaveAttribute('content', /index, follow/);
});

test('Open Graph and Twitter card tags are present', async ({ page }) => {
  await expect(page.locator('meta[property="og:title"]')).toHaveAttribute('content', /Lyndon Amat/);
  await expect(page.locator('meta[property="og:image"]')).toHaveAttribute('content', /og\.png/);
  await expect(page.locator('meta[name="twitter:card"]')).toHaveAttribute('content', 'summary_large_image');
});

test('exactly one h1 on the page', async ({ page }) => {
  await expect(page.locator('h1')).toHaveCount(1);
});

test('structured data (JSON-LD) is present and valid JSON', async ({ page }) => {
  const scripts = await page.locator('script[type="application/ld+json"]').allTextContents();
  expect(scripts.length).toBeGreaterThanOrEqual(2);
  for (const s of scripts) {
    expect(() => JSON.parse(s)).not.toThrow();
  }
});

test('favicon and manifest links resolve', async ({ page, request }) => {
  const favicon = await request.get('/favicon.svg');
  expect(favicon.ok()).toBeTruthy();
  const manifest = await request.get('/site.webmanifest');
  expect(manifest.ok()).toBeTruthy();
});
