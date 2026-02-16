# Fork Setup Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Reconfigure local repository to use IRusio/DDM-OS-Reminder fork as origin remote and push existing i18n changes.

**Architecture:** Simple git remote reconfiguration - replace origin URL pointing to dan-snelson's repository with the user's fork, then push local commits.

**Tech Stack:** Git, GitHub

---

## Task 1: Update Git Remote URL

**Files:**
- Modify: `.git/config` (via git command)

**Step 1: Update the origin remote URL**

Run:
```bash
git remote set-url origin https://github.com/IRusio/DDM-OS-Reminder.git
```

Expected: Command completes silently (no output on success)

**Step 2: Verify the change**

Run:
```bash
git remote -v
```

Expected output:
```
origin  https://github.com/IRusio/DDM-OS-Reminder.git (fetch)
origin  https://github.com/IRusio/DDM-OS-Reminder.git (push)
```

**Step 3: Commit documentation**

Documentation already committed in previous step (design doc).

---

## Task 2: Push Local Changes to Fork

**Files:**
- None (git operation only)

**Step 1: Check current branch status**

Run:
```bash
git status
```

Expected: On branch main, possibly with untracked files in Artifacts/ and .claude/

**Step 2: Push main branch to fork**

Run:
```bash
git push -u origin main
```

Expected output (similar to):
```
Enumerating objects: X, done.
Counting objects: 100% (X/X), done.
...
To https://github.com/IRusio/DDM-OS-Reminder.git
   [hash]...[hash]  main -> main
Branch 'main' set up to track remote branch 'main' from 'origin'.
```

**Step 3: Verify push succeeded**

Run:
```bash
git log --oneline -1
```

Then check GitHub: https://github.com/IRusio/DDM-OS-Reminder

Expected: Latest commit matches local commit, all i18n commits visible in fork's history

---

## Task 3: Final Verification

**Files:**
- None (verification only)

**Step 1: Verify remote configuration**

Run:
```bash
git remote -v
git branch -vv
```

Expected:
- Remote shows IRusio fork
- Branch shows tracking `[origin/main]`

**Step 2: Verify GitHub repository**

Navigate to: https://github.com/IRusio/DDM-OS-Reminder

Expected:
- Repository shows recent commits (166f7e4 test(i18n): verify all i18n functionality, etc.)
- All i18n work is visible in commit history
- Fork is ahead of original if viewing network graph

---

## Success Criteria

- ✅ `git remote -v` shows `origin` pointing to `https://github.com/IRusio/DDM-OS-Reminder.git`
- ✅ Local commits successfully pushed to fork
- ✅ `git branch -vv` shows `main` tracking `origin/main`
- ✅ GitHub repository at IRusio/DDM-OS-Reminder contains all local i18n commits

## Rollback Plan

If issues occur:

```bash
# Revert to original remote
git remote set-url origin https://github.com/dan-snelson/DDM-OS-Reminder.git
```

No data is lost during this process - all changes remain local until pushed.
