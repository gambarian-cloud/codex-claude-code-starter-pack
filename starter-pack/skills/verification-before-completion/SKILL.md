---
name: verification-before-completion
description: Use before saying a task is done. Run the real check, read the output, and only then claim success.
---

# Verification Before Completion

The rule is simple: no completion claims without fresh proof.

## Workflow

1. Name the command or check that proves the claim.
2. Run the full check.
3. Read the output and exit code.
4. Confirm it really proves the result.
5. Only then say it is done.

## Guardrails

- Lint is not enough by itself.
- Old test results do not count.
- If the check fails, say so clearly.
