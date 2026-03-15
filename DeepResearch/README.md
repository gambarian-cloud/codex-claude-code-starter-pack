# Deep Research Skill

Decision-grade research workflow for Codex and Claude Code.

This is the public landing page for the `deep-research` skill shipped in the Starter Pack.

## What It Is

This skill is for research questions where shallow search or one-source summaries are not enough:

- vendor and tool comparisons
- workflow and stack decisions
- privacy, retention, procurement, and policy-sensitive questions
- market maps and source-of-truth memos
- adopt / experiment / watch / reject decisions

It is designed to prevent the usual "search and retell" failure mode by forcing:

- question lock first
- source-layer separation
- primary-source verification
- contradiction tracking
- explicit uncertainty handling
- a final recommendation instead of a link dump

## Canonical Package

The actual skill package lives here:

- [starter-pack/skills/deep-research](../starter-pack/skills/deep-research/)

Main file:

- [SKILL.md](../starter-pack/skills/deep-research/SKILL.md)

Supporting references:

- [superiority-rubric.md](../starter-pack/skills/deep-research/references/superiority-rubric.md)
- [long-run-artifact-spec.md](../starter-pack/skills/deep-research/references/long-run-artifact-spec.md)
- [example-completed-pass.md](../starter-pack/skills/deep-research/references/example-completed-pass.md)

Starter assets:

- [assets/long-run-pack](../starter-pack/skills/deep-research/assets/long-run-pack/)

## Why This Skill Exists

Most so-called "deep research" workflows break in predictable ways:

- search results are treated as evidence
- sales pages decide the answer
- practitioner usage is guessed instead of checked
- contradictions are gathered but do not change the conclusion
- the final output is an essay instead of a usable decision memo

This skill is built to stop that.

## What Makes It Strong

- explicit evidence admissibility rules
- official / implementation / field / adversarial source layers
- decision-bearing numeric claim rules
- contradiction-to-decision mapping
- workload and requirement-lane coverage
- pricing and procurement discipline
- long-run artifact hygiene checks

## Package Shape

```text
starter-pack/skills/deep-research/
  SKILL.md
  agents/
  references/
    superiority-rubric.md
    long-run-artifact-spec.md
    example-completed-pass.md
  assets/
    long-run-pack/
```

## When To Use It

Use it when the task needs:

- multiple source layers
- source verification
- contradiction handling
- an auditable recommendation
- a benchmark-style comparison across options

Do not use it for:

- quick fact lookup
- one-doc answers
- routine code review
- pure implementation work

## Status

Current status: `adopt now`

It has already been benchmarked across multiple research domains and compared against:

- the built-in Codex deep-research skill
- an external public deep-research skill workflow

## Installation

If you are using the Starter Pack, the package already ships with it.

If you want to copy it manually, use:

```text
starter-pack/skills/deep-research/
```

and place it into the relevant skills directory for your agent environment.
