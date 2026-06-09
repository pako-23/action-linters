#!/bin/sh -eu

exec ansible-lint "${GITHUB_WORKSPACE}" 2>&1
