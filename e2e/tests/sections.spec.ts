import { test, expect } from '@playwright/test';

test.beforeEach(async ({ page }) => {
  await page.goto('/');
});

test('both project pins render with correct ref and status', async ({ page }) => {
  const okonomi = page.locator('.pin[data-ref="B-12"]');
  await expect(okonomi.locator('.ptitle')).toHaveText('Okonomi');
  await expect(okonomi.locator('.pstat')).toHaveText('WIP');
  await expect(okonomi.locator('.pstat')).toHaveAttribute('data-s', 'WIP');

  const site = page.locator('.pin[data-ref="C-19"]');
  await expect(site.locator('.ptitle')).toHaveText('This site');
  await expect(site.locator('.pstat')).toHaveText('Shipped');
  await expect(site.locator('.pstat')).toHaveAttribute('data-s', 'SHIPPED');
  await expect(site).toHaveAttribute('href', /github\.com\/amatlynd\/Portfolio/);
});

test('legend filter dims non-matching pins and clear resets them', async ({ page }) => {
  await page.locator('.leg-tag[data-f="Firebase"]').click();

  await expect(page.locator('.pin[data-ref="B-12"]')).not.toHaveClass(/dim/);
  await expect(page.locator('.pin[data-ref="C-19"]')).toHaveClass(/dim/);
  await expect(page.locator('#leg-clear')).toBeVisible();

  await page.locator('#leg-clear').click();
  await expect(page.locator('.pin[data-ref="C-19"]')).not.toHaveClass(/dim/);
});

test('index table lists both projects with correct status', async ({ page }) => {
  await page.locator('#btn-i').click();

  const rows = page.locator('#ix-body tr');
  await expect(rows).toHaveCount(2);
  await expect(rows.filter({ has: page.locator('[data-s="WIP"]') })).toContainText('Okonomi');
  await expect(rows.filter({ has: page.locator('[data-s="SHIPPED"]') })).toContainText('This site');
});

test('index table sorts by column on header click', async ({ page }) => {
  await page.locator('#btn-i').click();
  const firstRefBefore = await page.locator('#ix-body tr').first().locator('.td-ref').textContent();

  await page.locator('.ix-table th[data-col="ref"]').click();
  const firstRefAfterAsc = await page.locator('#ix-body tr').first().locator('.td-ref').textContent();

  await page.locator('.ix-table th[data-col="ref"]').click();
  const firstRefAfterDesc = await page.locator('#ix-body tr').first().locator('.td-ref').textContent();

  expect(firstRefAfterAsc).not.toBe(firstRefAfterDesc);
  expect([firstRefBefore, firstRefAfterAsc, firstRefAfterDesc]).toContain('B-12');
});

test('about view lists the tech stack groups', async ({ page }) => {
  await page.locator('#btn-a').click();
  await expect(page.locator('.ab-stack-grid')).toContainText('Flutter');
  await expect(page.locator('.ab-stack-grid')).toContainText('Astro');
});
