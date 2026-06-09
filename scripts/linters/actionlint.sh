#!/bin/sh -eu

exec actionlint "${GITHUB_WORKSPACE}/.github/workflows/*.yaml" "${GITHUB_WORKSPACE}/.github/workflows/*.yml" 2>&1
