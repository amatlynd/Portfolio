import { test, expect } from '@playwright/test';
import { waitForFlutter, semText } from '../flutter';

test.beforeEach(async ({ page }) => {
  await page.goto('/');
  await waitForFlutter(page);
});

test('shows name and title', async ({ page }) => {
  await expect(page.getByText("Hi, I'm").first()).toBeVisible();
  await expect(page.getByText('Lyndon Amat.').first()).toBeVisible();
});

test('shows available for work badge', async ({ page }) => {
  await expect(page.getByText('Available for work').first()).toBeVisible();
});

test('shows tagline', async ({ page }) => {
  await expect(
    page.getByText('Software developer focused on building clean').first()
  ).toBeVisible();
});

test('View My Work button scrolls to Projects', async ({ page }) => {
  await page.getByText('View My Work').first().click();
  // Flutter scrolls internally — wait for project content to enter the semantic tree
  await expect(semText(page, 'Portfolio Website').first()).toBeVisible({ timeout: 8000 });
});

test('Get In Touch button is visible', async ({ page }) => {
  await expect(page.getByText('Get In Touch').first()).toBeVisible();
});
