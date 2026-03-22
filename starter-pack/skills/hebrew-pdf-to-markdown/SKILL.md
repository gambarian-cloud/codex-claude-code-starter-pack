---
name: hebrew-pdf-to-markdown
description: Convert scanned Hebrew or mixed Hebrew-English PDFs into source-faithful Markdown with RTL-safe structure, page-level provenance, uncertainty tracking, and OCR QA. Use when Codex needs to read Hebrew PDFs, especially scanned, rotated, or medical documents, and preserve wording, dates, tables, dosages, and mixed-direction text instead of producing only a summary.
---

# Hebrew PDF To Markdown

Use this skill to build a canonical Markdown transcription from a Hebrew PDF. Prefer a faithful source artifact over polished OCR text.

## Workflow

1. Render page images before trusting any extraction.
   - Run `scripts/render_pdf_pages.py`.
   - Inspect page 1 visually.
   - If the page is upside down, rerun with `--rotate 180`.
   - Do not start with a horizontal flip unless the image truly looks mirrored.

2. Create a canonical OCR scaffold.
   - Run `scripts/init_hebrew_markdown.py`.
   - Point `--image-dir` at the rendered page folder.
   - Prefer `page_{page}_upright.png` image names.

3. Transcribe one page at a time from the page images.
   - Prefer direct visual reading by the model.
   - Treat Tesseract or other OCR as a rough draft only.
   - Keep the original language.
   - Keep summary or interpretation out of the OCR file.
   - If you want a reusable extraction prompt, read [references/page-ocr-prompt.md](./references/page-ocr-prompt.md).

4. Preserve the canonical page structure.
   - Keep one `## Page N` section per source page.
   - Keep `<!-- source-page: N -->`.
   - Keep one page image reference.
   - Wrap Hebrew text in `<div dir="rtl" align="right">...</div>`.
   - Keep one `### Uncertainties` block per page.

5. Validate early and often.
   - Run `scripts/validate_hebrew_markdown.py <file> --expected-pages N`.
   - Fix mojibake, missing sections, broken RTL wrappers, and hidden bidi problems before continuing.

6. Run an adversarial review on risky pages.
   - Always review pages with meds, dosages, dates, pathology markers, tables, signatures, or mixed Hebrew/English text.
   - If you want a reusable review prompt, read [references/page-review-prompt.md](./references/page-review-prompt.md).

## High-Risk Rules

- Do not translate inside the OCR file.
- Do not write transcriber notes as if they were physician text.
- Do not silently normalize blurry medical wording.
- If a line is ambiguous, keep only what is readable and explain the ambiguity in `### Uncertainties`.
- Keep OCR and summary as separate artifacts.

## Read These References When Needed

- Read [references/workflow.md](./references/workflow.md) for commands and done criteria.
- Read [references/failure-modes.md](./references/failure-modes.md) when OCR output looks suspicious, especially after Tesseract or terminal previews.

## Bundled Scripts

- `scripts/render_pdf_pages.py`: render PDFs to page PNGs and optionally rotate them upright.
- `scripts/init_hebrew_markdown.py`: generate the canonical Markdown scaffold.
- `scripts/validate_hebrew_markdown.py`: catch structural and encoding problems before downstream use.
