# Failure Modes

## Rotation Trap

- A Hebrew scan may be rotated `180°`, not mirrored.
- Do not start with a horizontal flip unless the image actually looks mirrored.
- Render, inspect, then rotate.

## Raw OCR Trap

- Tesseract can turn Hebrew into garbage Latin tokens such as `oy`, `nnn`, `TM`, `WN`, and similar fragments.
- Treat those outputs as hints, not truth.
- Never accept raw OCR as canonical without page-image review.

## Bidi / Encoding Trap

- Hidden bidi control characters can make text look correct while the file is corrupted.
- Prefer explicit HTML wrappers like `<div dir="rtl" align="right">...</div>`.
- Run the validator to catch suspicious tokens, control characters, and probable mojibake.

## Console Trap

- PowerShell or terminal output may display UTF-8 Hebrew badly even when the file itself is fine.
- Trust the UTF-8 file on disk and the page image more than a mangled terminal preview.

## Clinical Drift Trap

- A cleaned line is not automatically a faithful line.
- Do not rewrite blurry text into confident medical prose.
- If you normalize or omit a fragment, record that in `### Uncertainties`.

## Editorial Note Trap

- Keep transcriber notes out of the main page transcription.
- Do not embed notes like "this line is blurry" inside source text.
- Put those notes only in `### Uncertainties`.

## Table Trap

- Markdown tables are only safe when structure is genuinely clear.
- If table alignment is unstable, preserve it as plain text or line items instead of inventing a broken table.

## Summary Leakage Trap

- Keep the OCR file and the factual summary separate.
- The OCR file is for source-faithful transcription.
- The summary or timeline is a downstream artifact.
