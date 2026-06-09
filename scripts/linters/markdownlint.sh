#!/bin/sh -eu

exec markdownlint "${GITHUB_WORKSPACE}" 2>&1
