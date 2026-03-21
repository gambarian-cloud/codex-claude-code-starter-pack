---
question: "What is the best current approach for sharing reusable agent workflow instructions across Codex and Claude Code?"
date: "2026-03-21"
depth: deep
decision: adopt
confidence: high
source_count: 5
recommended_option: "Repo-owned canonical skill pack plus synced overlays"
coverage_gaps:
  - "YouTube not checked (low relevance)"
  - "Reddit not checked (low relevance)"
  - "Telegram, X, Facebook, Discord not checked (low relevance)"
---

# Example Completed Pass

Use this file as a calibration target for structure and decision quality. It is intentionally short and illustrative, not exhaustive.

## Example question

What is the best current approach for sharing reusable agent workflow instructions across Codex and Claude Code?

## Options Compared

- Repo-owned canonical skill pack plus synced overlays
- Separate per-tool native instruction sets with no shared canonical source

## Decision Table

| Option | Best case | Main risk | Decision |
| --- | --- | --- | --- |
| Repo-owned canonical pack plus synced overlays | Maximum reuse, auditability, and version control across tools | Sync drift and maintenance overhead | Adopt Now |
| Separate per-tool native instruction sets | Best fit to each tool's local affordances | Duplicate maintenance and faster divergence | Watch |

## Signal Assessment

- Shared markdown-based skill packs are the strongest reuse layer across the two tools.
- Repo-level always-on guidance is still necessary for stable project behavior.
- Community claims about "best" skill packs often exceed the underlying evidence.

## What Is True

- Codex supports `AGENTS.md` and `SKILL.md`-based skills.
- The current repo uses canonical `skills/` plus synced overlays.
- Long-run research quality improves when scope, sources, contradictions, and report structure live in files.

## What Seems Used In Practice

- Strong open-source research packs separate planning, evidence collection, and synthesis.
- Teams that care about auditability keep explicit evidence logs rather than only polished summaries.

## What Is Uncertain

- How much official support Anthropic will give to the current skill-pack ecosystem shape over time.

## What Would Change The Conclusion

- A documented vendor-native shared format adopted across both tools would weaken the case for repo-managed overlays.
- Evidence that synced overlays create more confusion than reuse would also change the recommendation.

## Decision / Outcome

- Adopt Now / Experiment / Watch / Reject / Not enough evidence: `Adopt Now` repo-owned canonical skills plus synced overlays.

## Recommended Next Move

- Keep one canonical skill pack in `skills/`, sync to tool overlays, and require evidence-backed updates for shared workflows.

## Prerequisites

- A reliable sync step and a team habit of treating `skills/` as the canonical layer.

## Blast Radius

- Moderate. The approach affects project structure, local overlays, and how both tools are configured to load shared instructions.

## Rollback / Escape Hatch

- Stop syncing overlays and keep only the tool-native instruction files if drift or maintenance overhead outweighs the reuse benefit.

## Best Argument Against This Recommendation

- Sync layers add maintenance overhead and can drift unless the sync step is reliable and routinely checked.

## Evidence Table

| Key claim | Claim status | Source IDs / URLs | Strongest counter-source or objection |
| --- | --- | --- | --- |
| Codex supports `AGENTS.md` and repo/user skill loading | verified | `src-1`, `src-2` | None material |
| Community skill READMEs often overstate capability | partially verified | `src-3`, `src-4` | Some repos are accurate and well maintained |
| File-based durable memory improves long-run research coherence | verified | `src-2`, `src-5` | Added file discipline can be overkill for small tasks |

## Contradictions

| Conflict | Source A | Source B | Resolution |
|---|---|---|---|
| Community skills "just work" across tools | `src-3` (README claims) | `src-4` (our verification found path and config differences) | Partially resolved --skills work but require per-tool sync step, not zero-config portability |

## Source layer coverage

- official truth: `src-1`, `src-2`
- implementation truth: `src-4` (our own verification pass)
- field evidence: `src-3`, `src-5`
- adversarial evidence: `src-4` (found that README claims exceeded reality)

## Biggest Blind Spot / Missed Signals

- This example does not benchmark whether future vendor-native marketplaces reduce the need for synced overlays.

## Coverage Gaps

- YouTube: not checked (low relevance for this topic)
- Reddit: not checked (low relevance for this specific configuration question)
- Telegram, X, Facebook, Discord: not checked (low relevance)

## Self-Evaluation

| Metric | Value | Notes |
|---|---|---|
| Source count | 5 | Saturation reached for this bounded question |
| Source class coverage | 4/4 layers | official, implementation, field, adversarial all present |
| Community/social sources | 0 | Not applicable for this configuration-focused question |
| Contradictions found | 1 | Resolved |
| Coverage gaps logged | 5 platforms | All low relevance, logged above |
| Confidence | high | Bounded question with direct verification |

## Example source handles

- `src-1`: official Codex AGENTS guidance --source_role: official, reliability: high
- `src-2`: official Codex long-horizon guidance --source_role: official, reliability: high
- `src-3`: verified review of community deep-research skill repos --source_role: field, reliability: medium
- `src-4`: current repo verification memo --source_role: implementation + adversarial, reliability: high
- `src-5`: open-source deep-research engine documentation --source_role: field, reliability: medium
