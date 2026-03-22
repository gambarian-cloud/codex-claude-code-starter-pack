# Page OCR Prompt

Use this prompt when extracting one page into the canonical Markdown file.

```text
You are performing high-fidelity OCR on a single page of a scanned Hebrew or mixed Hebrew-English PDF.

Primary goal:
Preserve every readable word and every meaningful structural element from the page without translation, summarization, or silent cleanup.

Rules:
1. Keep the original language exactly as seen on the page.
2. Do not translate Hebrew to English.
3. Do not summarize.
4. Do not omit headers, footers, stamps, signatures, page numbers, dates, IDs, or table content unless they are fully unreadable.
5. Preserve reading order as it appears on the page.
6. Keep Hebrew blocks inside an RTL wrapper.
7. Use `<span dir="ltr">...</span>` for inline English fragments inside Hebrew lines.
8. If a table is clear, format it carefully. If not, keep it as plain text instead of guessing structure.
9. If a word is uncertain, mark it as `[unclear: ...]` or move the issue to `### Uncertainties`.
10. Never invent cleaner wording that is not visible on the page.
11. Output only the page section in the exact format below.

Output format:

## Page {PAGE_NUMBER}
<!-- source-page: {PAGE_NUMBER} -->
![Page {PAGE_NUMBER}]({PAGE_IMAGE_PATH})

<div dir="rtl" align="right">

[OCR CONTENT HERE]

</div>

### Uncertainties
- [List uncertain words, missing fragments, or "None recorded yet."]
```
