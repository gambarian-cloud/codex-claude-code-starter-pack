# Building Websites Profile

This profile is for a beginner who mainly wants to build websites or simple web pages.

## What this profile adds

- website-focused guidance on top of the core baseline
- React-specific guidance on top of the builder layer
- a reminder to keep the framework stack focused even when the design layer is already installed

Concrete profile item:

- add `react-best-practices` when you start an active React or Next.js project

Why this specific item:

- it is the clearest local candidate we already track for frontend work
- it should stay opt-in, not part of the core baseline

Why this profile exists:

- website work often needs a little more structure than general use, but not a giant frontend pack

## Install steps

1. Apply the core baseline from [core-baseline.md](../manifests/core-baseline.md).
2. Apply the builder layer from [builder-default.md](../manifests/builder-default.md).
3. Keep the MCP baseline small. Do not add extra MCP servers unless the project clearly needs them.
4. Use the builder design stack first: `frontend-design` for the first pass, `design-elevation` for refinement, `web-design-guidelines` for usability checks, `playwright` for real browser review, and `vercel-deploy` for preview or publish help.
5. Add `react-best-practices` only if you are actively building a React or Next.js UI.
6. Prefer one focused React or Next.js skill over a giant frontend bundle.
7. Run [VERIFY.md](../VERIFY.md).

## Good fit

Choose this profile if you want help with:

- landing pages
- personal websites
- simple React or Next.js projects
- editing website copy and layout

## Do not include by default

- full design systems
- large frontend skill collections
- broad framework extras beyond the current stack
