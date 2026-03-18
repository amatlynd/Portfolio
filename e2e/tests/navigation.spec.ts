import { test, expect } from '@playwright/test';
import { waitForFlutter, semText } from '../flutter';

test.beforeEach(async ({ page }) => {
  await page.goto('/');
  await waitForFlutter(page);
});

test('nav bar shows logo and links', async ({ page }) => {
  await expect(page.getByText('Lyndon Amat').first()).toBeVisible();
  await expect(page.getByText('About').first()).toBeVisible();
  await expect(page.getByText('Projects').first()).toBeVisible();
  await expect(page.getByText('Contact').first()).toBeVisible();
});

test('clicking About scrolls to About Me section', async ({ page }) => {
  await page.getByText('About').first().click();
  // After Flutter scrolls, About Me should appear in the semantic tree
  await expect(page.getByText('About Me').first()).toBeVisible({ timeout: 5000 });
});

test('clicking Projects scrolls to Projects section', async ({ page }) => {
  await page.getByText('Projects').first().click();
  // Wait for Flutter to scroll and update semantics with below-fold content
  await expect(semText(page, 'Portfolio Website').first()).toBeVisible({ timeout: 8000 });
});

test('clicking Contact scrolls to Contact section', async ({ page }) => {
  await page.getByText('Contact').first().click();
  await expect(page.getByText('Email Me').first()).toBeVisible({ timeout: 8000 });
});

test('clicking logo scrolls back to top', async ({ page }) => {
  await page.getByText('Contact').first().click();
  await page.waitForTimeout(800);
  await page.getByText('Lyndon Amat').first().click();
  await expect(page.getByText("Hi, I'm").first()).toBeVisible({ timeout: 5000 });
});
