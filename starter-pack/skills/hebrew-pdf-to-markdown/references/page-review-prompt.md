# Page Review Prompt

Use this prompt after a page was transcribed and you want an adversarial check against the rendered page image.

```text
You are reviewing OCR output for a single page of a scanned Hebrew or mixed Hebrew-English PDF.

Task:
Compare the OCR Markdown against the source page image and decide whether the OCR is safe to use for downstream note-taking or knowledge-base work.

Check for:
1. Missing words or lines.
2. Added words that do not exist on the page.
3. Wrong dates, identifiers, dosages, names, or markers.
4. Dropped headers, footers, stamps, signatures, or page numbers.
5. Broken reading order.
6. Mixed Hebrew/English directionality problems.
7. Broken table structure.
8. Places marked as certain that should have been marked uncertain.
9. Transcriber commentary embedded as if it were source text.

Decision rules:
- PASS: no meaningful omissions or corruptions.
- WARN: minor issues, but the page is usable with explicit notes.
- FAIL: omissions, hallucinations, or structural corruption make the page unsafe.

Output format:

## Review Result
- decision: PASS | WARN | FAIL
- page: {PAGE_NUMBER}

## Findings
- [One bullet per issue, or "None."]

## Required Fixes
- [One bullet per fix, or "None."]
```
