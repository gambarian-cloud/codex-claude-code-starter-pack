from __future__ import annotations

import argparse
from pathlib import Path

import fitz
from PIL import Image


def render_page(page: fitz.Page, dpi: int) -> Image.Image:
    scale = dpi / 72
    pix = page.get_pixmap(matrix=fitz.Matrix(scale, scale), alpha=False)
    mode = "RGB" if pix.n < 4 else "RGBA"
    image = Image.frombytes(mode, [pix.width, pix.height], pix.samples)
    if image.mode != "RGB":
        image = image.convert("RGB")
    return image


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Render PDF pages to PNG and optionally rotate them to an upright orientation."
    )
    parser.add_argument("--pdf", required=True, help="Source PDF path.")
    parser.add_argument("--output-dir", required=True, help="Directory for rendered page PNGs.")
    parser.add_argument("--dpi", type=int, default=220, help="Render DPI. Default: 220.")
    parser.add_argument(
        "--rotate",
        type=int,
        default=0,
        choices=(0, 90, 180, 270),
        help="Rotate each rendered page clockwise. Default: 0.",
    )
    parser.add_argument(
        "--pattern",
        default="page_{page}_upright.png",
        help="Output filename pattern. Use {page} as the page placeholder.",
    )
    parser.add_argument("--force", action="store_true", help="Overwrite existing page images.")
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    pdf_path = Path(args.pdf)
    output_dir = Path(args.output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)

    if not pdf_path.exists():
        raise SystemExit(f"PDF not found: {pdf_path}")

    doc = fitz.open(pdf_path)
    written: list[Path] = []
    try:
        for index, page in enumerate(doc, start=1):
            output_path = output_dir / args.pattern.format(page=index)
            if output_path.exists() and not args.force:
                raise SystemExit(f"Output already exists: {output_path}. Use --force to overwrite.")

            image = render_page(page, args.dpi)
            if args.rotate:
                image = image.rotate(args.rotate, expand=True)
            image.save(output_path)
            written.append(output_path)
    finally:
        doc.close()

    print(f"Rendered {len(written)} page(s) to {output_dir}")
    for path in written:
        print(path)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
