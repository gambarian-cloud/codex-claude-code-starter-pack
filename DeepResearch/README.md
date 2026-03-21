# Deep Research

Decision-grade research skill for Codex and Claude Code.

Use it when a question is important enough that a shallow answer is dangerous.

## What it does

- locks the real decision before research starts
- reads local project context when the answer must fit the workspace
- separates official truth, implementation truth, field evidence, and adversarial evidence
- verifies important claims at source
- tracks contradictions and turns them into a recommendation

## Use it for

- vendor and tool comparisons
- workflow and stack decisions
- privacy, retention, procurement, and policy-sensitive questions
- market maps and source-of-truth memos
- adopt / experiment / watch / reject decisions

## Why it is good

- it does not let search results masquerade as evidence
- it does not let sales pages decide the answer
- it does not stop at a summary with no recommendation
- it produces research another operator can review and defend

## Canonical package

- [starter-pack/skills/deep-research](../starter-pack/skills/deep-research/)
- [SKILL.md](../starter-pack/skills/deep-research/SKILL.md)
- [superiority-rubric.md](../starter-pack/skills/deep-research/references/superiority-rubric.md)
- [long-run-artifact-spec.md](../starter-pack/skills/deep-research/references/long-run-artifact-spec.md)
- [example-completed-pass.md](../starter-pack/skills/deep-research/references/example-completed-pass.md)
- [assets/long-run-pack](../starter-pack/skills/deep-research/assets/long-run-pack/)

## Do not use it for

- quick fact lookups
- one-doc answers
- routine code review
- pure implementation work

## Status

`adopt now`

Benchmarked against:

- built-in Codex deep-research
- external public deep-research workflow
