---
name: vercel-deploy
description: Use when the user wants to preview or publish a website or app and get a live link. Prefer preview deploys unless the user explicitly asks for production.
---

# Vercel Deploy

Use this skill when a site or app should become viewable through a real link.

## Workflow

1. Check whether the project is already connected to git or Vercel.
2. Prefer a preview deployment first.
3. Show the user the deployment URL plainly.
4. Only use production deploys when the user clearly asks for production.

## Good default behavior

- If a preview link is enough, use preview.
- If login or account setup is required, explain only the next needed step.
- Keep the deploy path simple and do not force advanced Vercel setup up front.

## Guardrails

- Do not push to production by default.
- Do not hide account or login blockers.
- Do not say a site is live unless you actually have the deployment URL.
