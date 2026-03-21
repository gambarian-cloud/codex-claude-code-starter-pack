# Deep Research

Decision-grade research skill for Codex and Claude Code.

This package exists to answer hard project questions without collapsing into "search and retell."

It is the canonical shared deep-research workflow shipped inside Starter Pack.

If the question is important enough that a weak answer could waste time, money, architecture effort, or vendor trust, this is the package that is supposed to slow down just enough to get the answer right.

## Start Here

- [DeepResearch landing page](../../../DeepResearch/README.md)

## What This Package Contains

Canonical files:

- [SKILL.md](./SKILL.md)
- [references/superiority-rubric.md](./references/superiority-rubric.md)
- [references/long-run-artifact-spec.md](./references/long-run-artifact-spec.md)
- [references/example-completed-pass.md](./references/example-completed-pass.md)
- [assets/long-run-pack](./assets/long-run-pack/)

## What It Does

This package helps the agent:

- lock the actual decision before researching
- read local project context when the answer must fit the current workspace
- separate official truth, implementation truth, field evidence, and adversarial evidence
- verify key claims at source
- track contradictions and map them to the decision
- end with a recommendation instead of an essay

The point is not to sound thorough. The point is to produce research another operator could inspect and defend.

## Use It When

Use this package when the task needs:

- multiple source layers
- source verification
- contradiction handling
- a source-backed recommendation

Typical examples:

- "compare these vendors and tell me what we should adopt"
- "research the safest workflow for this project"
- "build a source-of-truth memo before we make a tool choice"

## Do Not Use It When

Do not use it for:

- quick lookups
- one-doc answers
- routine implementation work

## Why It Is Structured This Way

`SKILL.md` stays focused on workflow.

`references/` holds the heavier guidance:

- escalation rules
- audit criteria
- long-run artifact structure
- completed example

`assets/long-run-pack/` gives a ready-made externalized research file stack for longer runs.
