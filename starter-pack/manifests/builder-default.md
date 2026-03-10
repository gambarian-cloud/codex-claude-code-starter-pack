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
- keep the stack small until the first working version exists
- prefer one focused build skill over a giant pack
- add website or app specialization only when the project clearly needs it

Why this concrete addition matters:

- builders need one tool that encourages small verified steps
- `test-driven-development` is the strongest local candidate we already track for safer implementation work

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

## Next choice after this layer

Then choose one:

- [websites.md](../profiles/websites.md)
- [simple-apps.md](../profiles/simple-apps.md)

## Not included by default

- large frontend packs
- advanced deployment stacks
- orchestration-heavy app builders
- extra MCP servers without a clear project reason
