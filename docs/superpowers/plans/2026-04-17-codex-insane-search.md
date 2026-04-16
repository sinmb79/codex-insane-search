# Codex Insane Search Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a Codex-native adaptation of `insane-search` that is immediately usable locally and publishable as a standalone GitHub repository.

**Architecture:** The repository ships one Codex plugin and one local Windows installer. The plugin exposes a single main skill with focused reference documents for each search strategy. The installer links the repo plugin into the user's local Codex plugin path and updates the home marketplace manifest.

**Tech Stack:** Markdown, JSON, PowerShell, GitHub CLI

---

### Task 1: Scaffold and metadata

**Files:**
- Modify: `plugins/insane-search/.codex-plugin/plugin.json`
- Modify: `.agents/plugins/marketplace.json`
- Create: `LICENSE`
- Create: `.gitignore`

- [ ] Replace placeholder manifest metadata with public-repo-safe values.
- [ ] Set the plugin interface fields for Codex discovery.
- [ ] Keep repo-local marketplace entry aligned with the plugin path.

### Task 2: Search skill

**Files:**
- Create: `plugins/insane-search/skills/insane-search/SKILL.md`
- Create: `plugins/insane-search/skills/insane-search/references/*.md`

- [ ] Rewrite the original idea for Codex tools instead of Claude plugin semantics.
- [ ] Correct known documentation issues from the source repo.
- [ ] Keep the public references concise and practical.

### Task 3: Local install flow

**Files:**
- Create: `scripts/install-local.ps1`
- Create: `scripts/uninstall-local.ps1`
- Create: `scripts/validate.ps1`

- [ ] Install via junction so the repo stays live for local development.
- [ ] Update the home marketplace manifest safely.
- [ ] Add a validation script for repeatable smoke checks.

### Task 4: Public documentation

**Files:**
- Create: `README.md`
- Create: `README.ko.md`

- [ ] Write the English README as the default entry point.
- [ ] Add a Korean companion document as a separate file.
- [ ] Explain architecture, install path, validation, and limits.

### Task 5: Publish

**Files:**
- Modify: repository git metadata

- [ ] Validate manifests and scripts.
- [ ] Install locally.
- [ ] Commit the repo.
- [ ] Create a new GitHub repository and push `main`.
