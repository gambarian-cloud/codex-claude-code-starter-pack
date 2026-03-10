---
name: playwright
description: Use when the user wants to open a real site or app in a browser, click through it, take screenshots, verify a flow, or debug what the UI actually does.
---

# Playwright Browser Check

Use this skill when a website or app needs a real browser pass, not just code changes.

## Workflow

1. Start or reuse the local dev server for the current project.
2. Open the site or app in a real browser.
3. Check the main user flow with real clicks, typing, and navigation.
4. Look for broken layout, missing states, confusing buttons, and obvious bugs.
5. If helpful, capture a screenshot before claiming the UI is done.

## Good default checks

- The app opens without an obvious crash.
- The main page fits on screen and looks intentional.
- The main button or call to action is easy to find.
- Forms, menus, and links behave the way a normal person would expect.
- Loading, empty, and error states are not confusing.

## Guardrails

- Do not claim a website or app is done without a real browser pass when UI work changed.
- Do not rely only on reading source files for visual or interaction claims.
- Prefer one short real flow that proves the result over a long fake checklist.
