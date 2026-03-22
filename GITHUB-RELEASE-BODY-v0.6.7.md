## Codex + Claude Code Starter Pack v0.6.7

This patch adds one focused document utility to the default public bundle:

- `hebrew-pdf-to-markdown`

What changed:

- default install now includes the shared `hebrew-pdf-to-markdown` skill for Codex and Claude Code
- verification now checks that the Hebrew PDF skill is present in both tool folders
- docs now explain that this is an advanced utility for scanned Hebrew PDFs and works best when Python, PyMuPDF, and Pillow are available

What did not change:

- `hebrew-medical-pdf-to-markdown` was not added to the default public bundle in this release
- the medical variant remains a separate, higher-stakes skill instead of a beginner baseline default

Why this release exists:

- many real users need to turn scanned Hebrew PDFs into faithful Markdown without silently translating, summarizing, or flattening source detail
- this skill gives the public Starter Pack one narrow but highly practical document workflow without turning the pack into a giant bundle

Verification run for this release:

- imported skill quick validation: `PASS`
- smoke test on `Shura-first.pdf`: `PASS`
- clean temp install: `PASS`
- clean temp verify: `PASS`
