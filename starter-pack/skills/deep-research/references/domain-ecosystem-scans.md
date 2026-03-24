# Domain Ecosystem Scans

Use this reference during step 4.5 for domain ecosystem scans, landscape-first passes, and pack-design research.

## Core problem: Ecosystem Legibility

The goal of a domain ecosystem scan is not just "find more things." It is to make the domain legible:
- what is installable
- what is an ecosystem or library family
- what is infrastructure
- what is a paper/prototype frontier
- what is enterprise reality
- what is only signal, not action

Without this legibility step, agents compare incomparable things in the same list.

## Domain-native query guidance

Do not assume all tools in a domain self-describe as "skills" or "agents." Many production tools in specialized domains predate the agent paradigm and use their own vocabulary.

For domain ecosystem scans, also search by:
- domain-specific workflow names (e.g., "systematic review automation", "clinical NLP pipeline", "pharmacovigilance detection", "portfolio rebalancing")
- domain-specific tool categories (e.g., "FHIR integration", "DICOM processing", "OMOP harmonization", "broker statement parser")
- domain-specific registries and standards
- `awesome-<domain>` lists on GitHub
- domain conference tool demos and workshops

### Query construction pattern

For each domain, build queries in three layers:
1. **Domain noun + generic tool terms**: `<domain> tools`, `<domain> automation`, `<domain> workflow`
2. **Domain noun + AI/agent terms**: `<domain> agent`, `<domain> copilot`, `<domain> AI assistant`
3. **Domain-native vocabulary**: the terms practitioners in that field actually use

Layer 3 is the one most often missed. It requires reading at least one domain-native source before constructing queries.

## Enterprise and commercial landscape pass

When the question is about ecosystem shape, market landscape, or "what exists," the open-source layer alone is incomplete.

Check:
- enterprise vendor pages and product announcements
- press releases and analyst reports (Gartner, Forrester, CB Insights when accessible)
- commercial platforms with open-source components
- government programs and institutional deployments (NIH, NHS, EU initiatives)
- which parts of the market are invisible to GitHub search

### Minimums
- `long-run` landscape passes: at least 2 enterprise/commercial sources
- Log as coverage gap if enterprise layer was not checked

### What this answers
"What does the full market actually look like" vs. "what is on GitHub."

## Frontier and preprint pass

Only needed for `deep` and `long-run` passes in research-heavy domains (biomedical, ML, scientific computing, materials science, etc.).

Check:
- **arXiv** / **bioRxiv** / **medRxiv** -> preprint search
- **Conference proceedings** -> NeurIPS, ICLR, ISMB, AMIA, RECOMB, ACL, and domain-specific conferences
- **Lab blogs and institutional announcements**
- **Supplementary code** -> tools distributed as paper supplements rather than polished repos

### What this answers
"What is coming in 3-12 months" and catches tools distributed as supplementary code rather than polished repos. The preprint-to-repo pipeline runs 3-12 months in research-active fields.

### When to skip
Skip for standard tool/workflow comparisons, vendor evaluations, or domains that are not research-active.
