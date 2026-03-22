# Hebrew PDF to Markdown Workflow

## Goal

Convert a Hebrew or mixed Hebrew-English PDF into source-faithful Markdown without translation, silent cleanup, or bidi corruption.

## Default Operating Model

1. Render page images first.
2. Confirm orientation visually.
3. Create a canonical Markdown scaffold.
4. Transcribe one page at a time from images.
5. Treat raw OCR as a rough draft only.
6. Validate the Markdown structurally and for encoding damage.
7. Keep factual summaries in a separate file.

## Quick Start

Render pages:

```powershell
python scripts/render_pdf_pages.py `
  --pdf C:\path\to\document.pdf `
  --output-dir C:\path\to\pages `
  --rotate 180 `
  --force
```

Create a scaffold:

```powershell
python scripts/init_hebrew_markdown.py `
  --pdf document.pdf `
  --page-count 7 `
  --output C:\path\to\document.canonical-ocr.md `
  --image-dir C:\path\to\pages `
  --image-pattern page_{page}_upright.png `
  --force
```

Validate:

```powershell
python scripts/validate_hebrew_markdown.py `
  C:\path\to\document.canonical-ocr.md `
  --expected-pages 7
```

## Decision Rules

### 1. Render before OCR

- Do not trust text extraction from the PDF until you know whether it is text-native or a scanned image PDF.
- For scanned PDFs, always work from rendered page images.
- Inspect page 1 after rendering. If the page reads upside down, rerun with `--rotate 180`.

### 2. Prefer visual transcription over raw OCR

- Use the model to read the page image directly whenever possible.
- Use Tesseract or other OCR only as scaffolding.
- If model reading and OCR disagree on a dosage, date, identifier, or marker, trust the image and mark uncertainty if needed.

### 3. Keep the canonical structure stable

Every canonical OCR file should contain:
- one `## Metadata` section,
- one `## Page N` section per page,
- one source-page comment per page,
- one page image reference per page,
- one RTL wrapper per page,
- one `### Uncertainties` block per page.

### 4. Separate source OCR from interpretation

- Do not mix summaries into the OCR file.
- Do not translate inside the OCR file.
- Do not write transcriber commentary as if it were source text.
- Put uncertainty notes only in the `### Uncertainties` block.

## High-Risk Fields

Escalate these to stricter review:
- medication names and dosages,
- dates and timestamps,
- pathology markers,
- diagnosis names,
- tables,
- IDs and license numbers,
- seizure / aura descriptions,
- headers, footers, page numbers, and signatures.

## Definition of Done

A document is ready for downstream use only when:
- the canonical OCR file exists,
- the validator passes with no errors,
- warnings were reviewed,
- unclear lines are explicitly flagged,
- any summary or timeline was produced from the validated OCR, not from memory.
