# Long-Run Artifact Spec

Use this reference when a research pass escalates into `long-run`.

## Template pack

Reusable starter files live in:

- `assets/long-run-pack/`

Copy these files into `Research/<date>-<slug>/` before starting if the folder does not already exist.
If the destination folder already contains an intentional file stack, reuse it instead of overwriting it.

## Required files

### `00_scope.md`

Freeze:

- question
- audience
- in/out of scope
- time window
- geography
- what would change the conclusion

### `01_plan.md`

Track:

- workstreams
- source layers per workstream
- done-when rules
- progress
- decision notes
- comparison criteria and serious options when the pass is comparative

### `02_queries.md`

Start with sub-question decomposition (3-7 sub-questions), then maintain separate query groups:

- baseline
- implementation check
- field evidence (blogs, reports)
- community and practitioner media (YouTube, Reddit, HN, X/Twitter, Telegram, Facebook, Discord)
- adversarial
- gap closure

### `03_sources.jsonl`

Create this file manually as JSON Lines.

Recommended fields per line:

```json
{"id":"","url":"","title":"","publisher":"","date":"","accessed_utc":"","source_role":"","claim_tags":[],"reliability_notes":"","source_reliability":"","entity_type":"","maintainer_type":"","platform":"","artifact_type":"","stars":"","forks":"","updated_at":""}
```

Field meanings:

- `id`: short stable handle used by the report evidence table
- `source_role`: `official`, `implementation`, `field`, or `adversarial`
- `claim_tags`: short tags for the claims this source informs
- `source_reliability`: brief note such as `high`, `medium`, `self-reported`, or `counter-evidence`
- `entity_type`: optional label such as `standard`, `official-catalog`, `community-catalog`, `workflow-framework`, or `translation-layer`
- `maintainer_type`: optional label such as `vendor`, `individual`, `community`, or `company`
- `platform`: optional label such as `github`, `youtube`, `x`, `telegram`, `reddit`, `discord`, `forum`, `linkedin`, or `facebook`
- `artifact_type`: optional label such as `doc`, `dpa`, `terms`, `privacy-policy`, `trust-center`, `repo`, `issue`, `video`, `thread`, `post`, `podcast`, `talk`, or `catalog`
- `stars` / `forks` / `updated_at`: optional adoption fields for repo or catalog comparisons

### `04_notes/`

One note per source cluster or workstream. Use the `README.md` template as the baseline shape.

### `05_contradictions.md`

Keep unresolved conflicts visible until they are resolved or explicitly accepted as uncertainty.

Every contradiction must map to a decision impact:

- `resolved -> adopt`, `resolved -> watch`, `resolved -> experiment`, or `left uncertain`
- state what evidence resolved it, or what would resolve it if still open
- if a contradiction does not change any row in the decision table, either it is not material or the decision table is missing a criterion

### `06_report.md`

Update incrementally. Do not wait until the end to write the first synthesis.

Start the file with YAML front matter so the final report stays human-readable but is still easy for agents or simple tooling to parse.

Use this minimal shape:

```yaml
---
question: ""
date: ""
depth: standard|deep|long-run
decision: adopt|experiment|watch|reject|not-enough-evidence
confidence: low|medium|medium-high|high
source_count: 0
recommended_option: ""
coverage_gaps: []
---
```

The front matter is the machine-readable summary. Do not create a separate mandatory `07_decision.json` unless a workflow has a proven need for it.

The final report should preserve:

- the serious options compared when relevant
- the decision table when relevant
- the decision or explicit outcome
- the best argument against it
- what would change the conclusion
- source layer coverage
- the biggest blind spot or likely missed signal
- an evidence table for decisive claims with inline clickable URLs
- a Layer Compatibility Matrix (for tool/ecosystem comparisons) using Y/P/N/? notation
- a Coverage Gaps section logging inaccessible platforms or missing source classes
- a Self-Evaluation section with: source count vs saturation, class coverage, community/social source count, contradictions found, coverage gaps, confidence level

For adoption recommendations, the final report should also preserve:

- prerequisites
- blast radius
- rollback or escape hatch

When the recommendation touches enterprise adoption, privacy, compliance, or procurement, `Recommended Next Move` should also preserve the smallest viable procurement program:

- agreements or addenda that must exist
- logging / deletion / audit answers that must be ready
- subprocessor or DPA packet requirements
- disclosure or transparency obligations

The report must be self-contained: a reader should understand the full argument without opening supporting files. Claim status belongs in the report evidence table or a separate claim log, not on the source row.

## Optional files

Add these when the pass scope requires them. They are not mandatory. Number sequentially from where the required files end.

### `07_decision.md`

Canonical adopt/experiment/watch/reject table when the pass evaluates multiple candidates. Use when the front matter in `06_report.md` is not enough to capture per-candidate decisions.

### `08_watchlist.md`

Repos, tools, or ecosystem signals to monitor after the pass ends. Include cadence (weekly/monthly) and trigger conditions for re-evaluation.

### `09_pack-shape.md`

Recommended pack architecture when the pass is designing a domain pack. Define core vs optional vs separate-later vs reject boundaries.

### `10_cross-review.md`

Arbitration layer when multiple independent passes exist (e.g., parallel Codex and Claude passes). Capture:
- where the passes agree
- where they disagree
- merged decision per item
- what neither pass covered
