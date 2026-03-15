---
name: deep-research
description: Run a decision-grade, multi-source research pass that verifies claims across official docs, implementation evidence, field evidence, and counter-evidence, then turns them into a source-backed memo or an adopt/experiment/watch/reject decision. Use when the task needs multiple source layers, counter-evidence, contradiction handling, or a source-of-truth comparison across tools, vendors, workflows, repos, standards, or market/technical claims. Do not use for quick fact lookup, a single-doc answer, routine digest review, simple feature comparison, code review, or implementation-only work.
---

# Deep Research

## Contract

- Lock the decision question first.
- Separate what is true, what is implemented, what is used in practice, and what is only claimed.
- End with a recommendation, uncertainty statement, or explicit "not enough evidence."

## Read next only when needed

- Before choosing depth or collecting sources, run this escalation check.
- If any escalation condition matches, read [references/superiority-rubric.md](references/superiority-rubric.md) before proceeding.
- If the pass escalates to `long-run`, also read [references/long-run-artifact-spec.md](references/long-run-artifact-spec.md).
- Only skip the rubric when none of the escalation conditions match.

Use the rubric when any of these are true:

- the decision changes architecture, process, spend, or security posture
- the user wants "best possible", "deepest", "exhaustive", or "decision-grade" research
- the topic is contested, benchmark-heavy, or marketing-saturated
- multiple ecosystems, vendors, or source layers must be compared
- 3 or more ecosystems, vendors, or major options must be compared
- the recommendation must be auditable by another reviewer
- the topic is freshness-sensitive enough that stale model knowledge is risky

## Pick the smallest depth that can answer the question

- `standard`: one memo, 4 to 8 strong sources, at least 2 source layers, and at least 1 source that could falsify the likely answer
- `deep`: 8 to 15 strong sources, at least 2 adversarial or counter-evidence sources, contradiction handling, explicit recommendation
- `long-run`: multi-hour or high-stakes pass; externalize state under `Research/<date>-<slug>/` using:
  - `00_scope.md`
  - `01_plan.md`
  - `02_queries.md`
  - `03_sources.jsonl`
  - `04_notes/`
  - `05_contradictions.md`
  - `06_report.md`

For `long-run`, copy the starter pack from `assets/long-run-pack/` into `Research/<date>-<slug>/` unless that folder already contains an intentional file stack.

- Force `long-run` when any of these are true:
  - 3 or more ecosystems, vendors, or major options must be compared
  - the pass needs 3 or more source layers plus active contradiction tracking
  - the topic is freshness-sensitive and likely to drift during the run
  - losing provenance would make the recommendation unsafe or hard to review

Do not default to `long-run` for every question. Use it when scope, stakes, or uncertainty justify the overhead.

## Source model

Split sources before reading:

- `official truth`: docs, release notes, standards, official repos, source-of-truth product pages
- `implementation truth`: source code, config examples, issue threads, benchmark methods, reproducible artifacts
- `field evidence`: practitioner writeups, operator reports, curated lists, adoption signals, and platform-native practitioner content from places like YouTube, X/Twitter, Telegram, Reddit, Discord, forums, LinkedIn, or Facebook groups when they materially show what people actually do
- `adversarial evidence`: criticisms, failure reports, negative comparisons, security notes, unresolved issues

Use these roles consistently:

- capability claims need `official truth` or `implementation truth`
- workflow claims need `field evidence`
- strong recommendations need at least one counter-source or failure check

### Evidence admissibility

Search results are leads, not evidence. A search result tells you where to look. It is not proof until you verify the claim at the actual source page.

When verifying claims, use this source preference order:

1. official product/spec page at the manufacturer's own domain
2. official repo docs (README, install guide, API reference)
3. official issue tracker, changelog, or release notes
4. named practitioner report with disclosed hardware and methodology
5. independent test with disclosed methodology
6. everything else is a lead to be verified, not evidence by itself

Review aggregators, affiliate articles, and secondary summaries are leads. They are useful for discovery but do not count as evidence for decision-bearing claims.

When the question touches privacy, retention, residency, liability, compliance, or enterprise procurement, trust centers and sales pages are not enough by themselves. Read the operative documents where the edge cases live:

- DPA or data-processing terms
- privacy policy and retention/help-center docs
- abuse-monitoring, logging, or human-review docs
- enterprise security / audit docs
- BAA or other contractual addenda when relevant

If a recommendation depends on a vendor's privacy or compliance posture, at least one decisive claim must come from those operative documents, not just a marketing summary page.

### Decision-bearing numeric claims

A numeric claim (tokens per second, benchmark score, price, bandwidth) may appear in the decision table or recommendation only if it meets one of these:

- verified at an official spec page or repo docs
- comes from a benchmark with disclosed model, quantization, backend, prompt length, and workload shape
- comes from a named practitioner with disclosed hardware setup

If no source meets this bar, you may include directional estimates as ranges but must label them `partially verified` or `directional estimate` and must not let them be the decisive factor in the recommendation.

Quantified claims sourced from blogs, review aggregators, or media explainers (e.g., "4.7 billion views wiped") may inform discussion but cannot drive the analytical thesis, `What Is True`, or the final verdict without primary or multi-source corroboration. Label them `directional estimate` or `secondary` and keep them out of top-line findings.

When the question is about workflows, adoption, creator practice, or "what people actually use," do not limit `field evidence` to blogs and curated lists. Look for platform-native artifacts such as:

- YouTube walkthroughs, build logs, or postmortems
- X/Twitter threads
- Telegram channel posts or discussions
- Reddit threads
- Discord/forum discussions
- LinkedIn or Facebook posts only when they add real implementation or operator evidence

Treat these as evidence of practice, not evidence of capability. Do not let one viral post decide the conclusion.

For workflow-heavy or creator-heavy topics, include at least one platform-native practitioner source in `deep`, and at least two in `long-run` if such material exists.
If there is meaningful video-native practitioner evidence, include YouTube explicitly rather than relying only on text summaries of the same material.

When the question is about agent tools, workflow systems, or ecosystem reuse, map each serious option across these layers before judging portability:

- `always-on guidance`: `AGENTS.md`, `CLAUDE.md`, global instructions, or equivalent
- `rules`: scoped behavioral constraints, usually always-on or path-triggered
- `skills`: reusable procedures with `SKILL.md` and optional resources
- `manual workflows`: slash commands, workflow prompts, or explicit runbooks
- `memory`: auto or file-based durable context layers
- `adjacent control layers`: hooks, subagents, plugins, or marketplace packaging when material

## Workflow

1. Lock the research question.

Write down:

- the decision we are trying to make
- who the answer is for
- what a useful answer must include
- what is out of scope
- what would change the conclusion
- what workload lanes or requirement lanes the question contains (e.g., coding, transcription, vision, serving)

If the question names specific workloads or requirements, list them as lanes. Each lane must be covered by verified evidence or logged as an explicit coverage gap in the final report. Do not claim a workload is covered in the decision table if no stack or tool was actually verified for it.

If the question touches privacy, compliance, procurement, or geography, split those concerns into separate lanes rather than one generic "enterprise" lane. At minimum, separate:

- retention / training usage
- logging / auditability
- region / residency
- sovereignty / jurisdiction
- buyer-facing controls or procurement requirements

2. Decompose and build a search plan.

Before browsing anything:

- break the question into 3-7 sub-questions that together cover the full decision
- for each sub-question, draft 2-4 search queries across different source classes (official, implementation, field/social, adversarial)
- this produces a query pack of 10-25 planned searches; not all must run, but the plan must exist before the first search
- for `long-run`, write the query pack to `02_queries.md`

3. Build the comparison frame before reading.

For each candidate or claim, check:

- what is actually true today
- what is only promised or marketed
- what practitioners appear to do in reality
- what procedural delta it adds
- what it costs in time, risk, or permissions
- what breaks or stays painful if we do nothing

For privacy, compliance, or procurement questions, compare each serious option separately on:

- training usage and retention
- logging and auditability
- region / residency controls
- sovereignty / jurisdiction exposure
- enterprise control surface (SSO, RBAC, private networking, exportable logs, admin controls)
- what the buyer will still ask your team to prove

If this is a tool or ecosystem comparison, also classify each serious option as one or more of:

- standard or spec
- official catalog or marketplace
- community catalog
- workflow framework
- translation or sync layer

### Candidate reality check

Before proceeding to evidence gathering, verify for each candidate:

- does the product, version, or SKU actually exist? (check at the manufacturer's page)
- is the lineup and release date real, or assumed from memory?
- are there previous-generation or used-market options still shipping and price-competitive?
- is the recommendation at risk of building on a phantom product or MSRP fantasy?

For hardware comparisons specifically: a well-understood previous-gen option with stable pricing and known behavior may be stronger than a current-gen option with supply issues or immature software support. Do not skip it.

### Contract and procurement reality check

When the question touches enterprise adoption, privacy, compliance, or legal exposure, verify for each serious candidate:

- which claims are in a trust center or sales page versus a DPA, ToS, or privacy doc
- whether stricter controls are default, self-serve, approval-gated, or contract-gated
- whether residency is the same thing as sovereignty in this context, or a weaker guarantee
- what a small team would still need to provide in procurement (DPA, subprocessor list, deletion statement, logging story, security questionnaire answers, AI disclosure, SOC 2 or equivalent)

4. Gather sources across lanes.

Prefer:

- primary sources first for mechanism and support boundaries
- implementation artifacts when docs are vague
- field evidence only after the official baseline is clear
- for workflow/use-in-practice questions, field evidence should include at least one platform-native source class when available, not only blogs or curated lists

Do not inflate source count with repeats. Two strong sources beat ten paraphrases.

For hardware, tool, or workflow comparisons: require at least one concrete practitioner setup description in `deep` and at least two in `long-run` when the ecosystem is active. A concrete setup means a specific person's actual hardware model, software stack, and workflow with enough detail to reproduce or evaluate. Forum threads, build logs, and "share your setup" posts are the strongest form of this evidence. If no concrete practitioner setup is found, log it as a critical coverage gap.

For enterprise, privacy, compliance, or procurement questions: run a dedicated contract-and-policy pass before treating the official baseline as complete. Read the DPA, ToS, privacy/retention docs, abuse-monitoring docs, and any security or enterprise addenda you can access for each serious option.

Then run a procurement reality pass. The goal is not just "which vendor is better" but "what would a small team actually have to ship, document, or negotiate to close deals safely." Look for:

- DPA execution requirements
- subprocessor review burden
- security questionnaire expectations
- audit-log and deletion/export expectations
- AI disclosure or transparency requirements
- minimum compliance baselines such as SOC 2, BAA, or private networking

After the official and implementation lanes, run a dedicated community and practitioner media pass:

- YouTube: search for walkthroughs, tutorials, teardowns, postmortems related to the question
- Reddit: search `site:reddit.com <topic> experience` or similar
- HN: search `site:news.ycombinator.com <topic>`
- X/Twitter: search when accessible and relevant
- Telegram, Facebook, LinkedIn, Discord: use when they add real operator evidence, but log as a coverage gap if inaccessible

This is a separate pass from blog-based field evidence. Platform-native artifacts often reveal workflow patterns that blogs miss.

5. Extract evidence, not vibes.

For every important claim, record:

- the source and date
- what it supports
- what it contradicts
- why the source is credible or limited
- whether the claim is `verified`, `partially verified`, `unverified`, or `marketing only`

6. Chase contradictions and map them to decisions.

- go closer to the primary artifact
- prefer newer evidence when the topic is time-sensitive
- if conflict remains, keep both sides and state the uncertainty

Every contradiction must resolve to a decision impact, not just exist in a log:

- `resolved -> adopt` (evidence clearly favors one side)
- `resolved -> watch` (evidence favors one side but risk remains)
- `resolved -> experiment` (both sides have merit, needs hands-on testing)
- `left uncertain` (not enough evidence to resolve; state what would resolve it)

The contradiction log must change the decision table. If a contradiction does not affect any row in the decision table, either the contradiction is not material or the decision table is missing a relevant criterion.

7. Check source coverage and saturation.

Before writing the final memo, check:

- are all source classes covered (official, implementation, field/social, adversarial)?
- is any decisive claim supported by only one source?
- have community/practitioner sources been checked when the question involves workflows or adoption?
- if a source class is missing or inaccessible, log it as an explicit coverage gap

Do not use a fixed source count as the primary gate. The test is coverage saturation: would adding more sources likely change the conclusion? If yes, keep searching. If additional searches only produce paraphrases of what you already have, stop and write.

However, minimum floors still apply as a safety net:
- `standard`: do not stop below 4 sources
- `deep`: do not stop below 8 sources across at least 3 source classes
- `long-run`: do not stop below 12 sources across all 4 source classes

If the floor is met but saturation is not reached, keep searching. If saturation is reached below the floor, check whether a source class is missing before stopping.

8. Synthesize into a decision memo.

Before writing the decision sections, state your primary analytical thesis in 1-3 sentences. This is your own conclusion from the evidence, not a restatement of any single source. The thesis sets the frame for the rest of the memo. If you cannot state a thesis, the evidence may not be saturated yet.

Use:

- `Options Compared` when there are 2 or more serious options
- `Decision Table` when the pass is comparative
- `Signal Assessment`
- `What Is True`
- `What Seems Used In Practice`
- `What Is Uncertain`
- `What Would Change The Conclusion`
- `Decision / Outcome`
- `Recommended Next Move`
- `Best Argument Against This Recommendation`
- `Source Layer Coverage`
- `Biggest Blind Spot / Missed Signals`

If the pass recommends adoption, also preserve:

- `Prerequisites`
- `Blast Radius`
- `Rollback / Escape Hatch`

If the pass is inconclusive, say so explicitly instead of forcing an adoption verdict.

For `deep` and `long-run` passes, also include a compact evidence table or appendix with:

- key claim
- claim status
- source IDs or URLs (use inline clickable URLs, not just source IDs)
- strongest counter-source or unresolved objection

When the question touches enterprise adoption, privacy, compliance, or procurement, make `Recommended Next Move` concrete enough to survive a buyer conversation. It should not stop at vendor choice. Include the smallest viable procurement program when relevant:

- which agreements must be in place
- what logging / deletion / audit answer the team needs ready
- whether a subprocessor list or DPA packet is required
- whether AI disclosure or transparency obligations apply
- which control gaps remain your team's responsibility even if the vendor looks strong

For tool or ecosystem comparisons, also include a **Layer Compatibility Matrix**: a table of [layers x tools] with Y = native, P = partial, N = no, ? = unknown, and a short note per cell.

For `deep` and `long-run` passes, also include a **Self-Evaluation** section:

- source count and whether saturation was reached
- source class coverage (which of the 4 layers are represented)
- community/social source count (YouTube, Reddit, HN, X, Telegram, etc.)
- contradictions found and resolution status
- coverage gaps logged
- overall confidence: high / moderate / low

9. Verify claims against sources.

Before declaring done, spot-check the 3-5 most consequential claims:

- re-read the source that backs each claim
- confirm the claim is actually supported, not just adjacent
- if a claim cannot be verified, downgrade its status or remove it

This step exists because LLM-generated citations are often imprecise or hallucinated. Do not skip it.

10. Promote only durable procedural deltas.

If the pass reveals a repeatable workflow:

- update the relevant project-owned skill, config, or catalog
- keep only the non-obvious reusable procedure
- do not promote hype, one-off preferences, or unstable rankings

## Quality bar

- Every non-trivial claim must map to a source or be labeled as an inference.
- Separate date-sensitive facts from stable concepts.
- Use exact dates when freshness matters.
- Benchmarks count only if the method is inspectable.
- Stars, likes, and reposts are supporting evidence, not proof.
- Views, subscribers, likes, reposts, and follower counts are supporting evidence, not proof.
- Catalogs, marketplaces, and frameworks are not the same thing; label them correctly.
- If the answer is inconclusive, say so plainly.

### Pricing discipline

When the question involves buying decisions, separate these price types and do not mix them:

- `official MSRP`: manufacturer's listed price; verify at the official product page
- `current street price`: what the product actually sells for today at retail; verify from a retailer, price tracker, or dated practitioner report
- `used market price`: what the product sells for second-hand; verify from a marketplace listing or dated community report
- `regional price`: location-specific pricing when it differs materially

For software, service, or adoption decisions, also separate direct vendor price from total cost of ownership:

- vendor or API price
- gateway / orchestration cost
- compliance and procurement cost (SOC 2, legal review, questionnaires, support plans)
- operational cost (on-call, logging, monitoring, incident response)

A recommendation must not rely on MSRP if the street price is materially different. If used pricing is relevant, state the source and date. If you cannot verify a price, label it `unverified` and do not build the recommendation on it.

## Guardrails

- Do not collapse official truth, OSS enthusiasm, and operator lore into one bucket.
- Do not let one tweet, one Telegram post, or one curated list decide the outcome.
- Do not treat a YouTube walkthrough, conference talk, or creator demo as proof of real repeated adoption by itself.
- Do not cite README superiority claims as settled fact.
- Do not stop at "many people mention it"; find the backing artifact.
- Do not hide unresolved contradictions.
- Do not leave the result as a brainstorm. End with a decision.
