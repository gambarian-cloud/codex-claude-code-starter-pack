# Builder Default Manifest

This is the default layer for people who want to build things with Starter Pack.

Use it after the core baseline and before choosing a more specific build path.

## What this layer is for

Use this layer if you want help with:

- building websites
- building simple apps
- moving from ideas to working prototypes

Why this layer exists:

- building is a common default use case
- it deserves a clear path instead of being hidden inside one narrow profile

## Builder baseline

Start from the core baseline in [core-baseline.md](core-baseline.md).

Then add the default builder extras:

- install `test-driven-development` as the default build skill once you start building real features
- install `frontend-design` so the first build starts from a strong visual direction instead of generic defaults
- install `design-elevation` so the agent refines a working draft before stopping
- install `web-design-guidelines` to keep the UI readable and usable
- install `playwright` so the agent can check the real browser result
- install `vercel-deploy` so the agent can help preview or publish a first project
- keep the stack small until the first working version exists
- add website specialization only when the project clearly needs React or Next.js guidance

Why this concrete addition matters:

- builders need one tool that encourages small verified steps
- builders also need one design-direction skill and one design-refinement skill, otherwise the first site or app often stays functional but generic

## Builder skill expectations

At a minimum, the builder layer should support:

- planning a small project before coding
- breaking work into verifiable steps
- debugging systematically when something fails
- verifying before claiming a feature is done
- isolating risky or parallel work

The builder layer then combines:

- `brainstorming`
- `writing-plans`
- `executing-plans`
- `systematic-debugging`
- `verification-before-completion`
- `using-git-worktrees`
- `test-driven-development`
- `frontend-design`
- `design-elevation`
- `web-design-guidelines`
- `playwright`
- `vercel-deploy`

## Next choice after this layer

Then choose one:

- [websites.md](../profiles/websites.md)
- [simple-apps.md](../profiles/simple-apps.md)

## Not included by default

- giant frontend packs
- framework-heavy stacks the user did not ask for
- orchestration-heavy app builders
- extra MCP servers without a clear project reason
