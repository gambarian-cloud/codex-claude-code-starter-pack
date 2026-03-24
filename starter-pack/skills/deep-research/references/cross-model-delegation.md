# Cross-Model Delegation Protocol

Status: experiment
Use: optional, for long-run passes only

## When to use

Use when:
- Scope is `long-run` and the domain is broad enough that single-agent search will miss material
- Previous passes have shown 30%+ of the landscape was missed by a single agent
- The user explicitly requests cross-model validation

Do not use:
- For standard or deep passes
- When the domain is narrow enough for one agent to cover
- As a default step in every research pass

## How it works

1. Complete your own research pass first using the main skill workflow
2. Design a cross-model prompt that:
   - Lists what is ALREADY KNOWN (prevents re-discovery waste)
   - Specifies 4-6 categories of desired output
   - Asks for source URLs, not just names
   - Ends with "what would surprise me" or "top 5 things the prior search missed"
   - Includes length guidance: "aim for 10-20K chars" to prevent bloat
3. Send to 3-6 external models (e.g., ChatGPT, Gemini, Perplexity, Grok, Claude)
4. Cross-review results and extract:
   - Unique findings per model
   - Convergent findings (confirmed by 2+ models)
   - Contradictions between models
   - Model strengths observed

## Prompt design notes

- For academic-focused models (Semantic Scholar, Liner): use a different prompt focused on papers and datasets, not ecosystem mapping
- For practitioner-focused models (Perplexity, Grok): emphasize Reddit threads, YouTube walkthroughs, adoption quotes
- For broad models (ChatGPT, Gemini): use the standard prompt with all categories

## Output

Save as a numbered artifact. Prefer `10_cross-review.md` when that slot is free; otherwise use the next sequential artifact number.

Include a model performance comparison:

| Capability | Best model(s) | Notes |
|------------|--------------|-------|
| Novel repo/tool discovery | | |
| Enterprise/commercial landscape | | |
| Adversarial evidence with numbers | | |
| Practitioner evidence with quotes | | |
| Academic paper analysis | | |
| Non-GitHub distribution ecosystem | | |
| Unique findings per token | | |

This table helps future passes choose which models to delegate to based on domain and question type.

## Same-model parallel subagents

For broad `long-run` passes where the sub-question count is high (5+), you may also parallelize within a single agent environment by launching research subagents for different sub-questions simultaneously.

This is not cross-model delegation -> it is same-model parallelism using Claude Code's Agent tool or similar. Each subagent searches and returns findings for its sub-questions; the main session synthesizes.

Use when:
- The topic has 5+ independent sub-questions that do not depend on each other
- Single-threaded search would take unreasonably long
- Coverage breadth matters more than deep sequential reasoning

Do not use when:
- Sub-questions depend on each other's results
- The topic needs iterative deepening rather than breadth
- The main agent can handle the scope in reasonable time

## Costs and risks

- Expensive in time and tokens
- Creates dependency on external infrastructure
- Model outputs need the same verification as any other source (step 9)
- Do not treat cross-model agreement as proof -> models share training data biases
