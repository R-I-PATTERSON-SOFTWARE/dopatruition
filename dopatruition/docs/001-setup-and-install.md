### Step 2: The "Why" (Create an ADR)
This is the "Enterprise Secret." We create an **Architecture Decision Record (ADR)**. This logs the *decisions*, not just the code.

**Action:**
1.  Create a folder `docs` in your root.
2.  Create a file `docs/001-setup-and-install.md`.
3.  Paste this:

```markdown
# ADR 001: Environment Setup & Toolchain

## Context
Initial setup on Ubuntu 24.04 using `snap` resulted in linker errors (`ld.lld` not found) due to sandbox restrictions.

## Decision
We executed the "Nuclear Option":
1. Removed Flutter Snap (`sudo snap remove flutter`).
2. Installed Flutter manually via Git to `~/development/flutter`.
3. Configured `pubspec.yaml` to explicitly include `.env` as an asset.

## Consequences
- **Positive:** Full control over the build toolchain; Linux desktop builds work immediately.
- **Negative:** Manual updates required (`flutter upgrade`) instead of auto-updates.

## Status
Accepted & Implemented (Feb 6, 2026)