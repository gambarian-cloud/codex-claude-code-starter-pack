# Deep Research Skill

Decision-grade research workflow for Codex and Claude Code.

This is the public landing page for the `deep-research` skill shipped in the Starter Pack.

If you need research you can actually defend in a product review, architecture discussion, vendor meeting, or benchmark debate, this is the point of the skill.

## What This Project Is

This project-owned skill turns vague "go research this" requests into an auditable workflow another reviewer can follow and challenge.

It is built for teams that do not just want a clever answer. They want a research process that:

- checks official truth before repeating claims
- separates product reality from marketing language
- brings in practitioner evidence where workflow truth matters
- tracks contradictions instead of smoothing them over
- ends in a usable recommendation

## Why We Built It

Most AI "deep research" behavior still falls into one of two traps:

- fast but shallow search-and-retell
- long but sloppy synthesis that sounds smart without proving the key claims

We built this skill to create a third option: decision-grade research that is rigorous enough to trust and practical enough to use inside real project work.

## What It Is For

This skill is for questions where shallow search or one-source summaries are not enough:

- vendor and tool comparisons
- workflow and stack decisions
- privacy, retention, procurement, and policy-sensitive questions
- market maps and source-of-truth memos
- adopt / experiment / watch / reject decisions

It is designed to prevent the usual "search and retell" failure mode by forcing:

- question lock first
- project-context intake when the answer must fit a real workspace
- source-layer separation
- primary-source verification
- contradiction tracking
- explicit uncertainty handling
- a final recommendation instead of a link dump

## What Happens When It Runs

At a high level, the skill does four things:

1. locks the actual decision and the local context
2. builds a comparison frame before browsing
3. gathers evidence across official, implementation, field, and adversarial layers
4. turns the result into an adopt / experiment / watch / reject memo

This means the output is not just "interesting research." It is supposed to unblock a real decision.

## Why This Skill Is Strong

This skill is good for a simple reason: it is opinionated about the failure modes that make most AI research outputs untrustworthy.

It does not let the run stop at:

- a pretty summary with weak proof
- a sales page pretending to be ground truth
- a pile of links with no recommendation
- a benchmark claim with no disclosed methodology
- a contradiction log that never changes the answer

Instead, it pushes toward research that is:

- source-backed
- reviewable
- project-aware
- useful for real decisions

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

## Why It Lives In Starter Pack

Starter Pack is meant to give Codex and Claude Code a shared baseline that actually helps real project work. Deep research belongs here because many high-value decisions are blocked by research quality, not by missing code.

This skill is the part of the baseline that helps answer:

- what already exists
- what is actually true
- what people seem to do in practice
- what we should adopt now versus only watch

## Status

Current status: `adopt now`

It has already been benchmarked across multiple research domains and compared against:

- the built-in Codex deep-research skill
- an external public deep-research skill workflow

In those comparisons, this project-owned skill won on the things that matter most for real work:

- source discipline
- contradiction-aware synthesis
- decision quality
- recommendation usefulness

## Installation

If you are using the Starter Pack, the package already ships with it.

If you want to copy it manually, use:

```text
starter-pack/skills/deep-research/
```

and place it into the relevant skills directory for your agent environment.
