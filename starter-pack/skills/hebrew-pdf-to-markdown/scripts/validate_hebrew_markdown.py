from __future__ import annotations

import argparse
import re
from pathlib import Path


REPLACEMENT_CHAR = "\ufffd"
SUSPICIOUS_STRINGS = ("\u05d2\u20ac", "\u00e2\u20ac", "\u00c3", REPLACEMENT_CHAR)
HEBREW_LETTER_RE = re.compile(r"[\u05d0-\u05ea]")
GERESH = "\u05f3"
REQUIRED_METADATA_FIELDS = (
    "source_pdf",
    "page_count",
    "language_primary",
    "script_mix",
    "extraction_method",
    "extraction_status",
    "integrity_status",
    "security_pass",
    "created_at",
)
BIDI_CONTROL_CHARS = {
    "\u200e": "LRM",
    "\u200f": "RLM",
    "\u061c": "ALM",
    "\u202a": "LRE",
    "\u202b": "RLE",
    "\u202c": "PDF",
    "\u202d": "LRO",
    "\u202e": "RLO",
    "\u2066": "LRI",
    "\u2067": "RLI",
    "\u2068": "FSI",
    "\u2069": "PDI",
}


def line_number(text: str, index: int) -> int:
    return text.count("\n", 0, index) + 1


def find_control_characters(text: str) -> list[tuple[str, int, int]]:
    findings: list[tuple[str, int, int]] = []
    for idx, char in enumerate(text):
        codepoint = ord(char)
        if char in "\n\r\t":
            continue
        if (0 <= codepoint < 32) or (127 <= codepoint <= 159):
            findings.append((repr(char), codepoint, line_number(text, idx)))
    return findings


def find_bidi_controls(text: str) -> list[tuple[str, int]]:
    findings: list[tuple[str, int]] = []
    for idx, char in enumerate(text):
        if char in BIDI_CONTROL_CHARS:
            findings.append((BIDI_CONTROL_CHARS[char], line_number(text, idx)))
    return findings


def probable_mojibake(text: str) -> bool:
    hebrew_letters = len(HEBREW_LETTER_RE.findall(text))
    geresh_count = text.count(GERESH)
    return geresh_count > 20 and geresh_count > max(hebrew_letters * 0.2, 20)


def extract_page_sections(text: str) -> list[tuple[int, str]]:
    matches = list(re.finditer(r"(?m)^## Page (\d+)\s*$", text))
    sections: list[tuple[int, str]] = []
    for index, match in enumerate(matches):
        start = match.start()
        end = matches[index + 1].start() if index + 1 < len(matches) else len(text)
        sections.append((int(match.group(1)), text[start:end]))
    return sections


def validate_file(path: Path, expected_pages: int | None) -> tuple[list[str], list[str]]:
    errors: list[str] = []
    warnings: list[str] = []

    try:
        text = path.read_text(encoding="utf-8")
    except UnicodeDecodeError as exc:
        return [f"File is not valid UTF-8: {exc}"], warnings

    if "## Metadata" not in text:
        errors.append("Missing `## Metadata` section.")

    for field in REQUIRED_METADATA_FIELDS:
        if not re.search(rf"(?m)^- {re.escape(field)}:", text):
            errors.append(f"Missing metadata field: `{field}`.")

    if text.count("```") % 2 != 0:
        errors.append("Unbalanced fenced code blocks.")

    control_chars = find_control_characters(text)
    if control_chars:
        sample = ", ".join(f"{value} U+{codepoint:04X} @ line {line}" for value, codepoint, line in control_chars[:8])
        errors.append(f"Found control characters that suggest encoding corruption: {sample}")

    bidi_controls = find_bidi_controls(text)
    if bidi_controls:
        sample = ", ".join(f"{name} @ line {line}" for name, line in bidi_controls[:8])
        warnings.append(f"Found hidden bidi control characters: {sample}")

    for token in SUSPICIOUS_STRINGS:
        count = text.count(token)
        if count:
            errors.append(f"Found suspicious encoding token `{token}` {count} time(s).")

    if probable_mojibake(text):
        errors.append("Probable Hebrew mojibake detected from abnormal punctuation-to-letter ratio.")

    pages = extract_page_sections(text)
    if not pages:
        errors.append("No `## Page N` sections found.")
    else:
        page_numbers = [page_number for page_number, _ in pages]
        if page_numbers != list(range(1, len(page_numbers) + 1)):
            errors.append(f"Page sections are not sequential starting from 1: {page_numbers}")
        if expected_pages is not None and len(page_numbers) != expected_pages:
            errors.append(f"Expected {expected_pages} page sections, found {len(page_numbers)}.")

    if expected_pages is not None and re.search(rf"(?m)^- page_count:\s*{expected_pages}\s*$", text) is None:
        warnings.append(f"Metadata `page_count` does not exactly match expected value {expected_pages}.")

    for page_number, section in pages:
        if f"<!-- source-page: {page_number} -->" not in section:
            errors.append(f"Page {page_number}: missing source-page comment.")
        if re.search(rf"!\[Page {page_number}\]\([^)]+\)", section) is None:
            errors.append(f"Page {page_number}: missing page image reference.")
        if '<div dir="rtl" align="right">' not in section:
            errors.append(f"Page {page_number}: missing RTL wrapper.")
        if "</div>" not in section:
            errors.append(f"Page {page_number}: missing closing `</div>`.")
        if "### Uncertainties" not in section:
            errors.append(f"Page {page_number}: missing `### Uncertainties` block.")
        if "[OCR_PENDING]" in section:
            warnings.append(f"Page {page_number}: OCR placeholder is still present.")

    return errors, warnings


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Validate Hebrew OCR Markdown for structure and integrity.")
    parser.add_argument("path", help="Markdown file to validate.")
    parser.add_argument("--expected-pages", type=int, help="Expected number of page sections.")
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    path = Path(args.path)
    errors, warnings = validate_file(path, args.expected_pages)

    print(f"Validation target: {path}")
    print(f"Errors: {len(errors)}")
    print(f"Warnings: {len(warnings)}")

    if errors:
        print("\nERRORS")
        for item in errors:
            print(f"- {item}")

    if warnings:
        print("\nWARNINGS")
        for item in warnings:
            print(f"- {item}")

    if errors:
        print("\nSTATUS: FAIL")
        return 1

    print("\nSTATUS: PASS")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
