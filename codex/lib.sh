#!/usr/bin/env bash
set -euo pipefail

CODEX_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CODEX_ENV_FILE="${CODEX_ENV_FILE:-${CODEX_ROOT}/.codex.env}"

if [[ -f "${CODEX_ENV_FILE}" ]]; then
  # shellcheck disable=SC1090
  source "${CODEX_ENV_FILE}"
fi

MOODLE_DIR="${MOODLE_DIR:-${HOME}/projects/moodle}"
MOODLE_DOCKER_DIR="${MOODLE_DOCKER_DIR:-${HOME}/projects/moodle-docker}"
MOODLE_DOCKER_BIN_DIR="${MOODLE_DOCKER_BIN_DIR:-${MOODLE_DOCKER_DIR}/bin}"
WEBSERVER_SERVICE="${WEBSERVER_SERVICE:-webserver}"
WEBSERVER_USER="${WEBSERVER_USER:-www-data}"
MDBROWSER_SERVICE="${MDBROWSER_SERVICE:-browser}"
PHPUNIT_BIN="${PHPUNIT_BIN:-vendor/bin/phpunit}"
PHPCS_BIN="${PHPCS_BIN:-vendor/bin/phpcs}"
PHPCBF_BIN="${PHPCBF_BIN:-vendor/bin/phpcbf}"

MDOCKER_COMPOSE="${MDOCKER_COMPOSE:-${MOODLE_DOCKER_BIN_DIR}/moodle-docker-compose}"

function codex_fail() {
  echo "ERROR: $*" >&2
  exit 1
}

function codex_ensure_file() {
  local target="$1"
  [[ -f "${target}" ]] || codex_fail "Missing file: ${target}"
}

function codex_ensure_dir() {
  local target="$1"
  [[ -d "${target}" ]] || codex_fail "Missing directory: ${target}"
}

function codex_validate_env() {
  codex_ensure_dir "${MOODLE_DIR}"
  codex_ensure_dir "${MOODLE_DOCKER_BIN_DIR}"
  [[ -x "${MDOCKER_COMPOSE}" ]] || codex_fail "moodle-docker-compose is not executable: ${MDOCKER_COMPOSE}"
}

function codex_mdc() {
  codex_validate_env
  (
    cd "${MOODLE_DOCKER_BIN_DIR}"
    ./moodle-docker-compose "$@"
  )
}

function codex_exec_web() {
  codex_mdc exec "${WEBSERVER_SERVICE}" "$@"
}

function codex_exec_web_as_user() {
  local user="$1"
  shift
  codex_mdc exec -u "${user}" "${WEBSERVER_SERVICE}" "$@"
}

function codex_usage_env() {
  cat <<USAGE
Configuration:
  CODEX_ENV_FILE       Optional path to env file (default: ${CODEX_ROOT}/.codex.env)
  MOODLE_DIR           Moodle checkout path (default: ${HOME}/projects/moodle)
  MOODLE_DOCKER_DIR    moodle-docker path (default: ${HOME}/projects/moodle-docker)
  WEBSERVER_SERVICE    Docker service for PHP commands (default: webserver)
  WEBSERVER_USER       User for Behat CLI commands (default: www-data)
USAGE
}
