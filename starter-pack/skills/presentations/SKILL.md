---
name: presentations
description: Use when the user wants a presentation, slide deck, lesson slides, business deck, PowerPoint, or a short visual talk. Create a clear outline first, then build a simple deck that is easy to read and present.
---

# Presentations

Use this skill when the user wants slides, not just a document or a webpage.

## Workflow

1. Clarify the audience, goal, and desired length.
2. Turn the topic into a short outline before designing slides.
3. Keep one main idea per slide.
4. Prefer simple visuals, short copy, and clear hierarchy over crowded slides.
5. End with a file the user can actually review, edit, or present.

## Tool routing

- In Codex, prefer the built-in `slides` workflow when it is available so you can create or edit a real slide deck and export a `.pptx`.
- In Claude Code, use any available presentation or PowerPoint skill in the current surface if it exists.
- If a native presentation tool is not available, create a clean fallback deck as browser-viewable HTML or simple editable source files in the project folder.

## Guardrails

- Do not start by dumping full paragraphs onto slides.
- Do not skip the outline step for a new deck.
- Do not promise a `.pptx` export path if the current tool surface does not actually support it.
