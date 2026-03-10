# Codex Session Prompt (Moodle LMS)

Use this at the start of a Codex task in `~/projects/moodle/codex`.

```text
You are working on Moodle LMS code located at $MOODLE_DIR from .codex.env.
Use ./codex/* scripts for all dockerized commands.

Rules:
- Follow Moodle coding style and existing APIs/patterns.
- Keep changes minimal and local to the requested issue.
- Before editing, identify nearby Moodle examples and follow them.
- Run targeted checks for changed code:
  - ./codex/phpcs <touched paths>
  - ./codex/phpunit <targeted tests>
  - ./codex/behat <targeted tags> for behaviour/UI changes
- Include/adjust tests for every behavioural change.
- Summarize changed files, commands run, and outcomes.
- Propose commit message(s) and branch name suggestion.

Git expectations:
- One logical change per commit.
- Keep commit history reviewable.
- Suggest MDL issue style commit summary if issue key is known.
```
