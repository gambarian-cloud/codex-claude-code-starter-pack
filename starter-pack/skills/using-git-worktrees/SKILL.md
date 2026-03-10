---
name: using-git-worktrees
description: Use when parallel work or risky changes need isolation. Create a separate worktree so one task does not break another.
---

# Using Git Worktrees

Use this skill when two streams of work would collide in one working copy.

## Workflow

1. Create a new worktree for the risky or parallel task.
2. Run commands inside that worktree only.
3. Verify the fresh worktree before making large changes.
4. Merge or copy the result back only after verification.
5. Remove stale worktrees when done.

## Guardrails

- Do not use worktrees for trivial edits.
- Do not leave old worktrees around.
- Verify the clean worktree before blaming the new changes.
