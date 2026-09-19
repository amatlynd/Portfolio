import { test, expect } from '@playwright/test';

test.beforeEach(async ({ page }) => {
  await page.goto('/');
});

test('canvas view is active by default', async ({ page }) => {
  await expect(page.locator('#btn-c')).toHaveAttribute('aria-selected', 'true');
  await expect(page.locator('#view-canvas')).toBeVisible();
  await expect(page.locator('#view-index')).toBeHidden();
  await expect(page.locator('#view-about')).toBeHidden();
});

test('switching to Index view shows the projects table and hides canvas chrome', async ({ page }) => {
  await page.locator('#btn-i').click();

  await expect(page.locator('#btn-i')).toHaveAttribute('aria-selected', 'true');
  await expect(page.locator('#btn-c')).toHaveAttribute('aria-selected', 'false');
  await expect(page.locator('#view-index')).toBeVisible();
  await expect(page.locator('#view-canvas')).toBeHidden();
  await expect(page.locator('#legend')).toBeHidden();
  await expect(page.locator('#minimap')).toBeHidden();
});

test('switching to About view shows the about copy', async ({ page }) => {
  await page.locator('#btn-a').click();

  await expect(page.locator('#btn-a')).toHaveAttribute('aria-selected', 'true');
  await expect(page.locator('#view-about')).toBeVisible();
  await expect(page.locator('.ab-h1')).toContainText('design meets engineering');
});

test('"v" keyboard shortcut cycles through views', async ({ page }) => {
  await page.locator('#view-canvas').click();
  await page.keyboard.press('v');
  await expect(page.locator('#btn-i')).toHaveAttribute('aria-selected', 'true');

  await page.keyboard.press('v');
  await expect(page.locator('#btn-a')).toHaveAttribute('aria-selected', 'true');

  await page.keyboard.press('v');
  await expect(page.locator('#btn-c')).toHaveAttribute('aria-selected', 'true');
});
