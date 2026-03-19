# Starter Pack PRD

Date: 2026-03-10
Status: MVP beta
Product name: Codex + Claude Code Starter Pack

## Product Summary

Starter Pack is a small beginner-first setup product for fresh `Codex` and `Claude Code` users on Windows.

It helps a new user:

- get a safe baseline quickly
- understand what is being installed and why
- choose a small profile based on what they want to do

## Problem

New users face three common problems:

- setup advice is scattered and inconsistent
- many starter guides install too much too early
- beginners do not know which defaults are safe and which are risky

## Primary User

The primary user is a beginner or non-technical user on Windows who wants a calm first setup for `Codex` or `Claude Code`.

They want:

- a fast start
- plain language
- a small number of clear choices

## MVP

The MVP includes:

- one core baseline for everyone
- one default builder layer for users who want to build websites or apps
- three optional profiles:
  - `General Use`
  - `Building Websites`
  - `Building Simple Apps`
- a beginner-friendly automated installer
- an automated verification script
- a rollback script that restores backups or removes created files

The MVP does not include:

- a large profile library
- large write-capable automation by default
- advanced app scaffolding
- experimental life-stage profiles as stable defaults

## Core Baseline Contract

The core baseline always includes:

- global instruction files for `Codex` and `Claude Code`
- core workflow skills for planning, deep research, implementation, debugging, verification, and safe parallel work
- Claude Code safety defaults for secrets
- a small MCP layer:
  - `Context7`
  - `Sequential Thinking`
  - `GitHub MCP` read-only

This core should stay small, stable, and easy to explain.

## Profile Model

Profiles are optional.

They exist to keep the baseline small while still helping users with common goals.

Rules:

- start from core first
- if the user wants to build, apply the default builder layer before a specific build profile
- add only one specific profile at first
- keep profile guidance beginner-friendly
- do not weaken core safety defaults

Current profile shape:

- `General Use` can stop at core
- builders use `builder-default` first, then choose `Building Websites` or `Building Simple Apps`
- the builder layer should already include strong first-pass design direction, design elevation, UI review, browser checking, and deploy guidance

Later profile families to test, not ship as stable defaults yet:

- `Work`
- `Adult Life`
- `Family / Kids`

Why they are later:

- we do not yet have strong enough local evidence for the exact skill packs
- they need clearer scope than the builder track

## Safety Model

Starter Pack should prefer low-risk defaults:

- deny casual access to common secret paths
- keep GitHub access read-only by default
- avoid giant skill packs
- avoid write-capable MCP by default

## Verification Model

The MVP uses a repo-local verification script plus manual fallback checks.

Current verification shape:

- `VERIFY.ps1` checks baseline files, core skills, profile extras, and Codex MCP blocks
- `VERIFY.md` explains the same checks in plain language

This is enough for a first standalone release.

## Current Deliverables

This folder should contain:

- `START-HERE.cmd` - double-click installer entry point
- `INSTALL.ps1` - automated installer with profile menu and backup
- `VERIFY.ps1` - automated verification script
- `UNINSTALL.ps1` - rollback helper using the install receipt and backups
- `README.md`
- `APPLY.md` - manual install path
- `VERIFY.md` - manual verification checklist
- `PRD.md`
- `CHANGELOG.md`
- `assets/codex/AGENTS.md` - template for Codex instruction file
- `assets/claude/CLAUDE.md` - template for Claude Code instruction file
- `skills/` - all bundled skill files (17 skills)
- `manifests/core-baseline.md`
- `manifests/builder-default.md`
- `profiles/general-use.md`
- `profiles/websites.md`
- `profiles/simple-apps.md`

## Later

Good follow-up work after MVP:

- more profile coverage only after real beginner usage
- per-profile MCP recommendations
- a friendlier visual installer wrapper if the Windows-first flow proves valuable
