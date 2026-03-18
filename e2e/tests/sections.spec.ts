import { test, expect } from '@playwright/test';
import { waitForFlutter, semText } from '../flutter';

test.beforeEach(async ({ page }) => {
  await page.goto('/');
  await waitForFlutter(page);
});

// ── About ──────────────────────────────────────────────────────────────────

test('About section heading is visible', async ({ page }) => {
  await page.getByText('About').first().click();
  await expect(page.getByText('About Me').first()).toBeVisible({ timeout: 5000 });
});

test('About section shows bio text', async ({ page }) => {
  await expect(
    page.getByText('crafting clean, performant applications').first()
  ).toBeVisible();
});

test('About section shows skill tags', async ({ page }) => {
  for (const skill of ['Dart', 'Flutter', 'React', 'Git']) {
    await expect(page.getByText(skill).first()).toBeVisible();
  }
});

// ── Projects ───────────────────────────────────────────────────────────────

test('Projects section shows subheading', async ({ page }) => {
  await page.getByText('Projects').first().click();
  await expect(
    page.getByText("A selection of things I've built.").first()
  ).toBeVisible({ timeout: 8000 });
});

test('all three project cards are visible after scrolling', async ({ page }) => {
  await page.getByText('Projects').first().click();
  for (const title of ['Portfolio Website', 'Mobile App', 'Project Three']) {
    await expect(semText(page, title).first()).toBeVisible({ timeout: 8000 });
  }
});

test('project cards show tech tags', async ({ page }) => {
  await page.getByText('Projects').first().click();
  for (const tag of ['Dart', 'React', 'Node.js', 'TypeScript']) {
    await expect(page.getByText(tag).first()).toBeVisible({ timeout: 8000 });
  }
});

test('project cards show GitHub buttons', async ({ page }) => {
  await page.getByText('Projects').first().click();
  await expect(page.getByText('GitHub').first()).toBeVisible({ timeout: 8000 });
  expect(await page.getByText('GitHub').count()).toBeGreaterThanOrEqual(3);
});

// ── Contact ────────────────────────────────────────────────────────────────

test('Contact section heading is visible', async ({ page }) => {
  await page.getByText('Contact').first().click();
  await expect(page.getByText('Get In Touch').first()).toBeVisible({ timeout: 8000 });
});

test('Contact section shows intro text', async ({ page }) => {
  await page.getByText('Contact').first().click();
  await expect(
    page.getByText("I'm always open to new opportunities").first()
  ).toBeVisible({ timeout: 8000 });
});

test('Contact section shows all contact buttons', async ({ page }) => {
  await page.getByText('Contact').first().click();
  await expect(page.getByText('Email Me').first()).toBeVisible({ timeout: 8000 });
  await expect(page.getByText('LinkedIn').first()).toBeVisible({ timeout: 8000 });
});

test('footer shows Built with Flutter', async ({ page }) => {
  await page.getByText('Contact').first().click();
  await expect(page.getByText('Built with Flutter').first()).toBeVisible({ timeout: 8000 });
});
