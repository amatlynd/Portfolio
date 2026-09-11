import { test, expect } from '@playwright/test';

test.beforeEach(async ({ page }) => {
  await page.goto('/');
});

test('theme toggle switches data-theme and persists across reload', async ({ page }) => {
  const html = page.locator('html');
  const before = await html.getAttribute('data-theme');

  await page.locator('#theme-btn').click();
  const after = await html.getAttribute('data-theme');
  expect(after).not.toBe(before);
  expect(['light', 'dark']).toContain(after);

  await page.reload();
  await expect(html).toHaveAttribute('data-theme', after!);
});

test('sun/moon icons swap with the active theme', async ({ page }) => {
  const sunVisibleBefore = await page.locator('#ico-sun').isVisible();
  const moonVisibleBefore = await page.locator('#ico-moon').isVisible();
  expect(sunVisibleBefore).not.toBe(moonVisibleBefore);

  await page.locator('#theme-btn').click();

  await expect(page.locator('#ico-sun')).toBeVisible({ visible: !sunVisibleBefore });
  await expect(page.locator('#ico-moon')).toBeVisible({ visible: !moonVisibleBefore });
});

test('icons match the system colour scheme on first load', async ({ browser }) => {
  for (const colorScheme of ['light', 'dark'] as const) {
    const context = await browser.newContext({ colorScheme });
    const page = await context.newPage();
    await page.goto('/');
    // The button shows the icon for the theme you would switch *to*.
    await expect(page.locator('#ico-moon')).toBeVisible({ visible: colorScheme === 'light' });
    await expect(page.locator('#ico-sun')).toBeVisible({ visible: colorScheme === 'dark' });
    await context.close();
  }
});
