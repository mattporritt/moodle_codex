# Codex instructions for Moodle LMS work

## Non-negotiables
- Follow Moodle coding style and conventions.
  - Coding style: https://moodledev.io/general/development/policies/codingstyle
- Prefer existing Moodle APIs/patterns over new abstractions.
- Keep changes minimal and localized to the requested area.

## Workflow
1. Plan: list files you will touch, and why.
2. Implement: small, reviewable changes.
3. Quality gates (run via ./codex/*):
   - ./codex/phpcs <touched paths> (or explain if unavailable)
   - ./codex/phpunit <targeted tests>
   - ./codex/behat <targeted tags> when behaviour or UI flows change
4. Fix failures until green.
5. Propose commits:
   - one logical change per commit
   - include tests in the same change that introduced behaviour

## Scope control
- Only edit files required for the task.
- If touching shared/core APIs, increase test coverage accordingly.
- If uncertain about a convention, search within the repo for the closest existing pattern and copy it.

## Output expectations
- Summarise what changed and why
- Summarise test commands run and results
- Provide commit message suggestions