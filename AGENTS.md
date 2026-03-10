# AGENTS.md

Instructions for Codex when working from `~/projects/moodle/codex`.

## Scope

- Treat this repo as a command surface for a larger Moodle LMS checkout.
- Moodle code lives at `MOODLE_DIR` from `.codex.env`.
- Run dockerized actions via `./codex/*` scripts from this repo.

## Required workflow

1. Plan a minimal, issue-focused change.
2. Mirror nearby Moodle patterns before introducing new structure.
3. Apply code edits directly in `MOODLE_DIR`.
4. Run targeted checks for changed code:
   - `./codex/phpcs <touched paths>`
   - `./codex/phpunit <targeted tests>`
   - `./codex/behat <targeted tags>` for behaviour/UI changes
5. Report exact commands run and outcomes.

## Moodle standards

- Follow Moodle coding style and policies:
  - https://moodledev.io/general/development/policies/codingstyle
- Reuse existing Moodle APIs before adding abstractions.
- Keep diffs localized and reviewable.
- Include or update tests for behavioural changes.

## Git expectations

- One logical change per commit.
- Branch naming should align with Moodle workflow and issue key when known.
- Commit messages should use Moodle issue style when possible, for example:
  - `MDL-12345 component_name: concise imperative summary`

## Practical rules for this repo

- Place any smoke-test artifacts in `/_smoke_test` at repo root.
- Do not hardcode machine-specific absolute paths in committed scripts.
- Prefer `./codex/changed-files` and `./codex/preflight` to keep checks scoped.
