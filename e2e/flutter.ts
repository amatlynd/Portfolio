import { Page } from '@playwright/test';

/**
 * Waits for Flutter Web to finish rendering and enables the accessibility
 * semantic tree so Playwright's locators can find content.
 *
 * Flutter CanvasKit renders everything to <canvas>. Text is only accessible
 * via the semantic tree, which is activated by clicking Flutter's hidden
 * "Enable Accessibility" placeholder button (flt-semantics-placeholder).
 *
 * NOTE: Use `semText(page, 'text')` for text that may be part of a combined
 * semantic node (e.g. project card titles), as `getByText` uses innerText
 * while Flutter semantics use textContent.
 */
export async function waitForFlutter(page: Page): Promise<void> {
  // Wait for Flutter's rendering container to be attached
  await page.waitForSelector('flt-glass-pane', { state: 'attached', timeout: 20_000 });

  // Allow Flutter to finish its initial render
  await page.waitForTimeout(1500);

  // Activate the semantic tree by clicking Flutter's hidden accessibility button
  await page.evaluate(() => {
    (document.querySelector('flt-semantics-placeholder') as HTMLElement)?.click();
  });

  // Wait for semantic nodes to be populated
  await page.waitForFunction(
    () => document.querySelectorAll('flt-semantics').length > 5,
    { timeout: 10_000 }
  );
}

/**
 * Locates an flt-semantics element whose textContent contains the given string.
 * Use this for content inside combined semantic nodes (e.g. project card titles)
 * where getByText() fails because it matches innerText, not textContent.
 */
export function semText(page: Page, text: string) {
  return page.locator('flt-semantics').filter({ hasText: text });
}
