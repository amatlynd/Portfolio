import { test, expect } from '@playwright/test';
import { waitForFlutter, semText } from '../flutter';

const MOBILE_VIEWPORT = { width: 390, height: 844 };
const DESKTOP_VIEWPORT = { width: 1280, height: 800 };

// ── Desktop ────────────────────────────────────────────────────────────────

test('desktop: nav links are visible', async ({ page }) => {
  await page.setViewportSize(DESKTOP_VIEWPORT);
  await page.goto('/');
  await waitForFlutter(page);
  await expect(page.getByText('About').first()).toBeVisible();
  await expect(page.getByText('Projects').first()).toBeVisible();
  await expect(page.getByText('Contact').first()).toBeVisible();
});

test('desktop: project cards visible after scrolling to section', async ({ page }) => {
  await page.setViewportSize(DESKTOP_VIEWPORT);
  await page.goto('/');
  await waitForFlutter(page);
  await page.getByText('Projects').first().click();
  await expect(semText(page, 'Portfolio Website').first()).toBeVisible({ timeout: 8000 });
  await expect(semText(page, 'Mobile App').first()).toBeVisible({ timeout: 8000 });
  await expect(semText(page, 'Project Three').first()).toBeVisible({ timeout: 8000 });
});

// ── Mobile ─────────────────────────────────────────────────────────────────

test('mobile: hero text is visible', async ({ page }) => {
  await page.setViewportSize(MOBILE_VIEWPORT);
  await page.goto('/');
  await waitForFlutter(page);
  await expect(page.getByText("Hi, I'm").first()).toBeVisible();
});

test('mobile: opening menu shows nav links', async ({ page }) => {
  await page.setViewportSize(MOBILE_VIEWPORT);
  await page.goto('/');
  await waitForFlutter(page);
  // On mobile, nav links are hidden behind a bottom sheet opened by the menu icon
  // Click the first button in the AppBar area (the menu icon)
  await page.locator('flt-semantics[role="button"]').first().click();
  await page.waitForTimeout(600);
  await expect(page.getByText('About').first()).toBeVisible({ timeout: 5000 });
  await expect(page.getByText('Projects').first()).toBeVisible({ timeout: 5000 });
  await expect(page.getByText('Contact').first()).toBeVisible({ timeout: 5000 });
});
