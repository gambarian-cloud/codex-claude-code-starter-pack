# Building Simple Apps Profile

This profile is for a beginner who wants to build small apps without jumping into a complex production stack.

## What this profile adds

- app-oriented guidance on top of the core baseline
- one concrete implementation-quality recommendation
- a recommendation to keep the stack small and understandable
- a reminder to verify often instead of adding more tools

Concrete profile item:

- add `test-driven-development` when your app starts growing behavior, state, or user-visible logic

Why this specific item:

- simple apps get messy quickly without a tight red-green-refactor loop
- it is already one of the stronger skill candidates in the current catalog

Why this profile exists:

- beginners building apps often add too much tooling before the first working version

## Install steps

1. Apply the core baseline from [core-baseline.md](../manifests/core-baseline.md).
2. Apply the builder layer from [builder-default.md](../manifests/builder-default.md).
3. Keep the MCP baseline at the default set unless you hit a real blocker.
4. Add `test-driven-development` when the app has enough behavior to benefit from tests.
5. Prefer small verified steps over broad setup work.
6. Run [VERIFY.md](../VERIFY.md).

## Good fit

Choose this profile if you want help with:

- CLI tools
- simple local apps
- small scripts with a UI
- beginner project builds where clarity matters more than scale

## Do not include by default

- large orchestration layers
- advanced deployment tooling
- write-capable automation you do not yet understand
