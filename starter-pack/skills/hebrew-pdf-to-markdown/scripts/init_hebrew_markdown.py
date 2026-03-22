from __future__ import annotations

import argparse
import os
from datetime import date
from pathlib import Path


def build_page_block(page_number: int, image_ref: str) -> str:
    return f"""## Page {page_number}
<!-- source-page: {page_number} -->
![Page {page_number}]({image_ref})

<div dir="rtl" align="right">

[OCR_PENDING]

</div>

### Uncertainties
- None recorded yet.

"""


def relative_path(from_dir: Path, to_path: Path) -> str:
    return os.path.relpath(to_path, start=from_dir).replace("\\", "/")


def build_document(
    pdf_name: str,
    page_count: int,
    output_file: Path,
    image_dir: Path | None,
    image_pattern: str,
) -> str:
    lines: list[str] = [
        f"# {pdf_name} - Canonical OCR",
        "",
        "## Metadata",
        f"- source_pdf: `{pdf_name}`",
        f"- page_count: {page_count}",
        "- language_primary: Hebrew",
        "- script_mix: Hebrew, English",
        "- extraction_method: pending",
        "- extraction_status: pending",
        "- integrity_status: pending",
        "- security_pass: pending",
        f"- created_at: {date.today().isoformat()}",
        "",
    ]

    for page_number in range(1, page_count + 1):
        if image_dir is None:
            image_ref = f"IMAGE_PATH_PENDING/{image_pattern.format(page=page_number)}"
        else:
            image_path = image_dir / image_pattern.format(page=page_number)
            image_ref = relative_path(output_file.parent, image_path)
        lines.append(build_page_block(page_number, image_ref))

    lines.extend(
        [
            "## Notes",
            "",
            "- Keep OCR and summary separate.",
            "- Use `<span dir=\"ltr\">...</span>` for inline English fragments inside Hebrew lines.",
            "- Run the Hebrew Markdown validator before downstream use.",
            "",
        ]
    )
    return "\n".join(lines)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Create a canonical Hebrew OCR Markdown scaffold.")
    parser.add_argument("--pdf", required=True, help="Source PDF filename or label.")
    parser.add_argument("--page-count", required=True, type=int, help="Expected number of pages.")
    parser.add_argument("--output", required=True, help="Output Markdown path.")
    parser.add_argument("--image-dir", help="Directory containing rendered page images.")
    parser.add_argument(
        "--image-pattern",
        default="page_{page}_upright.png",
        help="Image filename pattern. Use {page} as the page placeholder.",
    )
    parser.add_argument("--force", action="store_true", help="Overwrite the output file if it exists.")
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    output_file = Path(args.output)
    image_dir = Path(args.image_dir) if args.image_dir else None

    if output_file.exists() and not args.force:
        raise SystemExit(f"Output file already exists: {output_file}. Use --force to overwrite.")

    output_file.parent.mkdir(parents=True, exist_ok=True)
    content = build_document(args.pdf, args.page_count, output_file, image_dir, args.image_pattern)
    output_file.write_text(content, encoding="utf-8")
    print(f"Wrote scaffold: {output_file}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
