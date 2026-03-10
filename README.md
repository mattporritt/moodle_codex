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

## First-day setup

1. Add this repo as a submodule inside your Moodle checkout:

```bash
git -C ~/projects/moodle submodule add <YOUR_REPO_URL> codex
git -C ~/projects/moodle submodule update --init --recursive
```

2. Configure local paths for your machine:

```bash
cd ~/projects/moodle/codex
cp .codex.env.example .codex.env
```

3. Edit `.codex.env` and confirm these values:

- `MOODLE_DIR="$HOME/projects/moodle"`
- `MOODLE_DOCKER_DIR="$HOME/projects/moodle-docker"`
- `WEBSERVER_SERVICE="webserver"` (or your service name)
- `WEBSERVER_USER="www-data"` (or your preferred container user)

4. Verify wiring end to end:

```bash
./codex/doctor
./codex/up
```

5. Prepare the test environments once per clean site build:

```bash
./codex/install
./codex/phpunit-init
./codex/behat-init
```

## Daily workflow with Codex app

1. Open Codex with cwd at `~/projects/moodle/codex`.
2. Start each session with [`PROMPT_TEMPLATE.md`](/Users/mattp/projects/moodle/codex/PROMPT_TEMPLATE.md).
3. Ask Codex to edit code in `MOODLE_DIR` but run all Dockerized actions via `./codex/*`.
4. Require targeted checks before completion:

- `./codex/phpcs <touched paths>`
- `./codex/phpunit <targeted tests>`
- `./codex/behat <targeted tags>` for UI/behaviour changes

## Core commands

- `./codex/help` - show available commands
- `./codex/up` - start containers (`up -d`)
- `./codex/down` - stop containers
- `./codex/ps` - show docker service status
- `./codex/logs [service]` - follow docker logs
- `./codex/install` - install Moodle database/site
- `./codex/phpunit-init` - initialize PHPUnit environment
- `./codex/phpunit [test-path-or-filter]`
- `./codex/behat-init`
- `./codex/behat --tags=@tagname`
- `./codex/phpcs <paths...>`
- `./codex/phpcbf <paths...>`
- `./codex/changed-files [base-ref]` (default `origin/main`)
- `./codex/preflight [paths...]` (defaults to changed files)
- `./codex/web <command...>` - run arbitrary command in web container as `WEBSERVER_USER`
- `./codex/web-root <command...>` - run arbitrary command in web container as default/root user
- `./codex/mdc <compose args...>` - direct moodle-docker-compose passthrough

## Branch and commit discipline

In your Moodle repo (`~/projects/moodle`):

- Create one branch per issue/task.
- Keep one logical change per commit.
- Include tests in same commit as behaviour changes.
- Use `./codex/changed-files <base-branch>` to scope linting.

Suggested commit summary style when an issue key exists:

```text
MDL-12345 component_name: concise imperative summary
```

## Notes

- Use `./codex/*` commands directly from this repository.
- This repo does not need to be inside `~/projects/moodle-docker`; it points there via `.codex.env`.
