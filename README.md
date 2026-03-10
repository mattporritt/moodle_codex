# Moodle Codex Runner

This repository gives Codex a stable command surface for Moodle LMS development when Moodle and moodle-docker live in separate directories.

## What this solves

- Keeps Codex commands consistent across projects.
- Targets a large external Moodle checkout instead of this repo.
- Runs install, PHPUnit, Behat, PHPCS, and PHPCBF through moodle-docker.
- Keeps all runner commands in a single `codex/` directory.

## Recommended layout

```text
~/projects/moodle                 # Moodle LMS checkout
~/projects/moodle-docker          # moodle-docker checkout
~/projects/moodle/codex           # this repo as a git submodule
```

## Setup

1. Add this repo as a submodule inside your Moodle checkout:

```bash
git -C ~/projects/moodle submodule add <YOUR_REPO_URL> codex
git -C ~/projects/moodle submodule update --init --recursive
```

2. Configure paths for your machine:

```bash
cd ~/projects/moodle/codex
cp .codex.env.example .codex.env
```

3. Edit `.codex.env` if your paths/services differ.

4. Verify wiring:

```bash
./codex/doctor
```

## Core commands

- `./codex/up` - start containers (`up -d`)
- `./codex/down` - stop containers
- `./codex/install` - install Moodle database/site
- `./codex/phpunit-init` - initialize PHPUnit environment
- `./codex/phpunit [test-path-or-filter]`
- `./codex/behat-init`
- `./codex/behat --tags=@tagname`
- `./codex/phpcs <paths...>`
- `./codex/phpcbf <paths...>`
- `./codex/changed-files [base-ref]` (default `origin/main`)
- `./codex/preflight [paths...]` (defaults to changed files)

## How to run Codex against Moodle

Open Codex in `~/projects/moodle/codex` so it can use this command surface.

Use [`PROMPT_TEMPLATE.md`](/Users/mattp/projects/moodle_codex/PROMPT_TEMPLATE.md) as your session bootstrap prompt.

Recommended operating pattern:

- Tell Codex the issue/goal.
- Require targeted tests and coding-style checks before completion.
- Ask for explicit command outputs summary in each response.

## Branch and commit discipline

In your Moodle repo (`~/projects/moodle`):

- Create one branch per issue/task.
- Keep one logical change per commit.
- Include tests in same commit as behaviour changes.
- Use `./codex/changed-files <base-branch>` to scope linting.

Suggested commit summary style when issue key exists:

```text
MDL-12345 component_name: concise imperative summary
```

## Notes

- Use `./codex/*` commands directly from this repository.
- This repo does not need to be inside `~/projects/moodle-docker`; it points there via `.codex.env`.
