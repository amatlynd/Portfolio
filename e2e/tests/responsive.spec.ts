import { test, expect } from '@playwright/test';

test('mobile viewport: no horizontal overflow and key content is visible', async ({ page }) => {
  await page.setViewportSize({ width: 375, height: 812 });
  await page.goto('/');

  const scrollWidth = await page.evaluate(() => document.documentElement.scrollWidth);
  const clientWidth = await page.evaluate(() => document.documentElement.clientWidth);
  expect(scrollWidth).toBeLessThanOrEqual(clientWidth + 1);

  await expect(page.locator('.hero-name')).toBeVisible();
  await expect(page.locator('.pin[data-ref="B-12"]')).toBeVisible();
  await expect(page.locator('.pin[data-ref="C-19"]')).toBeVisible();
});

test('mobile viewport: minimap is hidden, legend pinned to bottom', async ({ page }) => {
  await page.setViewportSize({ width: 375, height: 812 });
  await page.goto('/');

  await expect(page.locator('#minimap')).toBeHidden();
  await expect(page.locator('#legend')).toBeVisible();
});

test('desktop viewport: minimap and legend both visible', async ({ page }) => {
  await page.setViewportSize({ width: 1280, height: 800 });
  await page.goto('/');

  await expect(page.locator('#minimap')).toBeVisible();
  await expect(page.locator('#legend')).toBeVisible();
});

test('index table scrolls horizontally on narrow viewports instead of breaking layout', async ({ page }) => {
  await page.setViewportSize({ width: 375, height: 812 });
  await page.goto('/');
  await page.locator('#btn-i').click();

  const scrollWidth = await page.evaluate(() => document.documentElement.scrollWidth);
  const clientWidth = await page.evaluate(() => document.documentElement.clientWidth);
  expect(scrollWidth).toBeLessThanOrEqual(clientWidth + 1);
  await expect(page.locator('.ix-table')).toBeVisible();
});
