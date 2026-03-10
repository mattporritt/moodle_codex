# Codex Instructions For Moodle LMS Work

## Scope
- This repository is a command surface for Moodle development.
- The Moodle codebase lives at `MOODLE_DIR` from `.codex.env`.
- Run dockerized operations via `./codex/*` scripts.

## Non-negotiables
- Follow Moodle coding style and conventions:
  - https://moodledev.io/general/development/policies/codingstyle
- Reuse existing Moodle APIs/patterns before introducing new abstractions.
- Keep changes minimal, localized, and issue-focused.

## Standard workflow
1. Plan impacted files and risks.
2. Implement smallest viable change.
3. Run quality gates:
   - `./codex/phpcs <touched paths>`
   - `./codex/phpunit <targeted tests>`
   - `./codex/behat <targeted tags>` for behaviour/UI changes
4. Fix failures before proposing commit.
5. Prepare commit suggestions:
   - one logical change per commit
   - tests included in the same commit that changes behaviour

## Working with a large codebase
- Prefer targeted search (`rg`) and narrow edits.
- If unsure about conventions, find and mirror nearby Moodle patterns.
- Avoid broad refactors unless explicitly requested.

## Output expectations
- Summarise what changed and why.
- List exact test/lint commands run and outcomes.
- Suggest commit message(s) aligned to the change.
