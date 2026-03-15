# Deep Research Superiority Rubric

Use this rubric when the task must be stronger than a normal research pass in depth, defensibility, and source coverage.

The goal is not "more words." The goal is to make the answer survive review by someone smart, skeptical, and busy.

## What "better than average deep research" means

A superior pass should beat a shallow agent on four dimensions:

1. better scoping
2. broader and more diverse evidence
3. stronger contradiction handling
4. clearer decision output

If a pass gets longer but not stronger on those dimensions, it is not better research.

## Escalation rule

Use this rubric automatically when any of these are true:

- the user asks for the best current setup, best practice, ideal stack, or a source-of-truth memo
- the decision affects architecture, security, compliance, money, or a long-lived workflow
- vendors and community reports disagree
- there are obvious marketing incentives or benchmark wars
- the topic is recent enough that stale memory is risky
- 3 or more ecosystems, vendors, or major options must be compared
- the pass needs a recommendation that another reviewer should be able to audit quickly

## Operating modes

### Standard

Use when the question is bounded and medium stakes.

Minimum gates:

- at least 4 strong sources
- at least 2 source layers
- at least 1 source that could falsify the likely answer

### Deep

Use when the question is comparative, contested, or materially important.

Minimum gates:

- at least 8 strong sources
- at least 3 source layers
- at least 2 adversarial or counter-evidence sources
- explicit contradiction log, even if short

### Long-run

Use when the question is broad, high-stakes, or requires hours of work.

Force `long-run` using the trigger list in `SKILL.md`. Do not maintain a separate conflicting list here.

Minimum gates:

- externalized file stack under `Research/<date>-<slug>/`
- milestone plan with acceptance criteria
- structured source log
- incremental synthesis instead of one giant final write

When starting `long-run`, copy the template pack in `assets/long-run-pack/` unless the destination folder already contains an intentional file stack, then follow [long-run-artifact-spec.md](long-run-artifact-spec.md).

## Research loop

Do not browse in one undifferentiated blob. Use explicit passes.

### Pass 0: Question lock

Write:

- exact decision
- audience
- time window
- geography
- non-goals
- what would change the conclusion

If these are fuzzy, the whole pass degrades.

### Pass 0.5: Decomposition and search plan

Before the first search:

- decompose the question into 3-7 sub-questions
- for each sub-question, draft 2-4 queries across source classes (official, implementation, field/social, adversarial)
- group queries into a query pack of 10-25 planned searches
- for `long-run`, write to `02_queries.md`
- for `deep`, keep the pack in working memory or scratch notes

This is not a checklist to execute blindly. It is a plan that prevents ad hoc browsing and makes the search auditable.

### Pass 1: Official baseline

Answer only:

- what the product, standard, or repo officially claims
- what the support boundary is
- what the documented mechanism is

Do not mix in community praise yet.

### Pass 1.25: Contract and policy reality

When the question touches privacy, retention, legal exposure, compliance, or enterprise procurement, do not stop at the trust center or product page.

Check the operative documents:

- DPA or data-processing terms
- ToS / commercial terms
- privacy policy and retention docs
- abuse-monitoring or human-review docs
- security / audit docs
- BAA or other enterprise addenda when relevant

This pass answers "what is contractually or operationally true when edge cases matter?"

### Pass 1.5: Layer map

For tool, workflow, or ecosystem comparisons, map each serious option across:

- always-on guidance
- rules
- skills
- manual workflows
- memory
- adjacent control layers such as hooks, subagents, plugins, or marketplaces

Do this before deciding what is "portable" or "reusable." Many bad recommendations come from comparing one tool's rules layer to another tool's skills layer as if they were the same thing.

### Pass 2: Implementation check

Look for:

- source code
- configuration examples
- benchmark methodology
- issues, PRs, failure reports
- evidence that the documented mechanism exists in practice

This pass is where many marketing claims die.

### Pass 3: Field evidence (blogs, reports, adoption signals)

Look for:

- practitioner writeups and blog posts
- adoption signals
- strong example repos
- operator complaints
- evidence of repeated workflow patterns

This pass answers "do real people actually use it this way?" from text-based sources.

When the question is about workflows, operator practice, creator stacks, GTM practice, or real-world adoption, actively seek 1–3 named practitioner examples. For each, capture:

- name or team
- date
- direct source URL
- concrete tool stack or workflow behavior
- why it matters to the decision

Quotes and episode numbers are useful but not mandatory. This rule is conditional — do not force named practitioner capture for pure architecture, compliance, or spec-comparison questions where operator identity does not change the conclusion.

### Pass 3.25: Procurement reality

When the recommendation affects enterprise adoption, pricing, or buyer trust, run a procurement pass:

- what agreements or paperwork are actually needed
- which controls buyers will still ask the team to prove
- whether SOC 2, DPA execution, private networking, audit logs, deletion answers, or AI disclosure become gating items

Do not end at "vendor X looks compliant." Ask what the small team would still need to ship or negotiate.

### Pass 3.5: Community and practitioner media

Run a dedicated pass for platform-native practitioner content:

- **YouTube** (preferred when relevant): walkthroughs, tutorials, teardowns, build logs, postmortems. Search `"<topic> workflow"`, `"<tool> tutorial 2026"`, `"how I use <tool>"`.
- **Reddit**: `site:reddit.com <topic> experience`, operator discussions, comparison threads.
- **HN**: `site:news.ycombinator.com <topic>`, practitioner threads.
- **X/Twitter**: `<tool> workflow`, practitioner threads, when accessible.
- **Telegram**: channel posts or discussions, when accessible via public web or user-supplied links. If inaccessible, log as coverage gap.
- **Facebook/LinkedIn**: only when they add real implementation or operator evidence. If not checked, log as coverage gap.
- **Discord/forums**: community-specific evidence when relevant.

Minimums:

- `deep`: at least 1 platform-native practitioner source
- `long-run`: at least 2 platform-native practitioner sources when such material exists
- include YouTube explicitly when the ecosystem has meaningful video content

Do not treat social content as equivalent to official or implementation evidence. Use it to establish practice, friction, repetition, and operator language.

When a platform is inaccessible or produces nothing relevant, log it as an explicit coverage gap in the report rather than silently skipping it.

### Search fallback for platform-restricted queries

If site-restricted searches (e.g., `site:reddit.com`) return no results or are not supported by the search tool:

1. try broader queries that include the platform name: `reddit LocalLLaMA [topic] experience 2026`
2. try navigating directly to known community URLs if you know them
3. try the platform's own search if accessible
4. if all attempts fail, log the coverage gap with the queries you tried

Do not silently skip a platform. Either find evidence there or document the failed attempt with query details.

When using repo adoption as evidence, classify each serious repo as:

- standard or spec
- official catalog or marketplace
- community catalog
- workflow framework
- translator or sync layer

Collect, at minimum:

- maintainer or owner type
- stars
- forks
- maintenance recency

Then state clearly what those numbers do and do not prove.

### Pass 4: Adversarial search

Run deliberate counter-searches:

- "`<candidate>` problems"
- "`<candidate>` limitations"
- "`<candidate>` security"
- "`<candidate>` alternatives"
- "`why not <candidate>`"
- "`<benchmark>` methodology criticism"

Also search for:

- **platform-specific issues**: Windows, Linux, WSL, macOS edge cases when the topic involves developer tools
- **organizational risk**: acquisitions, ownership changes, layoffs, funding status when evaluating vendor-dependent tools
- **prediction markets or betting odds**: when the question is about future standards, adoption trajectories, or contested outcomes

For vendor or platform comparisons, run at least one adversarial search per serious candidate on:

- incidents or breaches
- litigation, fines, or enforcement
- ambiguous policy wording
- approval-gated controls that may fail in practice
- migration pain or dependency traps

Do not close the research until you have tried to break the leading conclusion.

### Pass 5: Gap closure and reflection

Before writing the final recommendation, ask:

- which important claim still has only one source?
- which source classes are missing?
- which likely objection is unanswered?
- what is still ambiguous because of date, version, or scope?
- which platforms were inaccessible (log as coverage gap)?
- do any assumed product names, versions, release dates, or lineups need verification at the manufacturer's page?
- are there previous-generation or used-market options still available that were not evaluated?
- does each workload lane from the locked question have verified stack coverage or an explicit gap?
- have contract / DPA / policy documents been read where the recommendation depends on compliance posture?
- have residency and sovereignty been treated separately where jurisdiction matters?
- for buying or enterprise-adoption questions, is there a procurement program, not just a vendor ranking?

Then close only the highest-value gaps.

After drafting the synthesis, re-read your own draft and ask:

- does the draft actually answer the locked question from Pass 0?
- is there a claim in the recommendation that is not backed by any source in the evidence table?
- is the strongest counter-argument stated fairly, or was it softened?
- would a skeptical reviewer find an obvious gap?

If the reflection reveals a material weakness, run one more targeted search before finalizing.

## Source diversity rules

The pass is incomplete if all useful evidence comes from one class of source.

### For product, tool, or vendor comparisons

Try to include:

- official docs or release notes
- official repo or source
- one benchmark or evaluation method if performance is central
- one practitioner or operator source
- one counter-source

### For academic or scientific topics

Try to include:

- original paper or journal source
- benchmark, dataset, or method appendix when relevant
- at least one replication, critique, or competing result
- secondary explainer only if it adds field interpretation

### For workflow or "how teams actually work" topics

Try to include:

- official mechanics
- implementation artifacts
- 2 or more practitioner sources from different contexts
- at least one failure report or cautionary source
- at least one platform-native practitioner source when available

## Claim status rules

Do not present every sentence with the same certainty.

Use these labels internally while working:

- `verified`: supported by strong primary or implementation evidence
- `partially verified`: directionally supported, but some scope, version, or completeness risk remains
- `unverified`: plausible but not supported enough to rely on
- `marketing only`: currently sourceable mainly to self-promotion or weak claims

If a claim changes the recommendation, it should almost never remain `unverified`.

## Freshness rules

When the topic is time-sensitive:

- prefer newer sources over older summaries
- state exact dates
- confirm benchmarks, releases, pricing, security posture, and product behavior from current sources
- do not reuse stale leaderboard positions as if they are stable facts

## Timeboxing rules

Depth is not the same as infinite search.

Use bounded loops:

- spend the first block locking scope and frame
- spend the next block on official and implementation truth
- spend the next block on field and adversarial evidence
- spend the final block on synthesis and gap closure

If additional search only produces paraphrases, stop expanding and write.

## Mandatory outputs by task shape

### If comparing options

Include:

- options compared
- a decision table
- strongest case for each serious option
- why the winner wins
- why the losers lose
- best argument against the winner
- source layer coverage
- biggest blind spot or likely missed signal

### If recommending adoption

Include:

- adopt now / experiment / watch / reject
- prerequisites
- blast radius
- rollback or escape hatch
- best argument against this recommendation
- a compact evidence table for the decisive claims

If the task is not actually an adoption decision, do not force this shape. Use an explicit outcome such as `not enough evidence` or a narrower explanatory conclusion.

### If the result is inconclusive

Include:

- what is known
- what remains uncertain
- what single next check would reduce uncertainty the most
- which decisive claims are still only partially verified

## Failure patterns to avoid

- source hoarding without synthesis
- repeating the official docs in different words
- treating stars or buzz as proof
- treating views, likes, reposts, or subscriber counts as proof
- mistaking a catalog, marketplace, or framework for a standard
- stopping after finding supporting evidence for the first promising answer
- using benchmark claims without reading the method
- collapsing "documented", "implemented", and "widely used" into the same statement
- writing a recommendation that ignores the user's actual risk tolerance or operating context

## Completion gates

Do not call the pass done until these are true:

- the decision question is answered directly
- the strongest non-trivial claims have source support
- the leading conclusion faced at least one adversarial search pass
- unresolved contradictions are visible
- the recommendation is concrete enough to act on
- the memo tells the reader what would change the conclusion
- for `deep` and `long-run`, the final output preserves claim status for the decisive claims
- for recommendations, the strongest unresolved objection remains visible in the final output
- source saturation check: would adding more sources likely change the conclusion? If yes, keep searching. If no, proceed. Minimum floors still apply as safety net: standard >= 4, deep >= 8 across 3+ classes, long-run >= 12 across all 4 classes.
- for `deep` and `long-run`: the report is self-contained -- a reader should understand the full argument without opening supporting files
- for `deep` and `long-run`: the evidence table uses inline clickable URLs, not just source IDs
- for `deep` and `long-run`: the 3-5 most consequential claims have been spot-checked against their sources (citation verification)
- for `long-run`: every URL cited in the final report must appear in `03_sources.jsonl`. If a URL was added during a late enhancement pass, back-fill it into the source log or remove it from the report. Do not close with a drifted ledger.
- for tool/ecosystem comparisons: a Layer Compatibility Matrix is present
- coverage gaps (inaccessible platforms, missing source classes) are logged explicitly
- final artifact hygiene: before closing, verify encoding cleanliness (no mojibake), source-count consistency between self-evaluation and `03_sources.jsonl`, contradiction-count consistency between self-evaluation and `05_contradictions.md`, and section completeness against the required output list

### Self-evaluation (mandatory for deep and long-run)

Before declaring done, add a self-evaluation section to the report:

| Metric | Value | Notes |
|---|---|---|
| Source count | N | vs saturation |
| Source class coverage | N/4 layers | which layers present |
| Community/social sources | N | YouTube, Reddit, HN, X, Telegram, etc. |
| Contradictions found | N | resolved / open |
| Coverage gaps logged | list | which platforms skipped and why |
| Confidence | high / moderate / low | honest assessment |

This forces the researcher to honestly assess the output before claiming completion.

## Long-run file discipline

For multi-hour research, maintain:

- `00_scope.md`: freeze the target and non-goals
- `01_plan.md`: milestones, acceptance criteria, and decision notes
- `02_queries.md`: query pack including adversarial searches
- `03_sources.jsonl`: source log with role and reliability notes
- `04_notes/`: extracted evidence by workstream
- `05_contradictions.md`: conflicts and resolution status
- `06_report.md`: working synthesis, updated incrementally

This is the research equivalent of durable project memory. If the run is long and this stack is missing, drift is likely.
