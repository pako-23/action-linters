# Code Linters

[![Latest Release](https://img.shields.io/github/v/release/pako-23/action-linters?sort=semver)](https://github.com/pako-23/action-linters/releases/latest)
[![Lint Codebase](https://github.com/pako-23/action-linters/actions/workflows/linter.yaml/badge.svg)](https://github.com/pako-23/action-linters/actions/workflows/linter.yaml)
[![License](https://img.shields.io/github/license/pako-23/action-linters)](LICENSE)

A GitHub Action that runs a set of linters on your codebase. The
results will be reported as commit statuses and as job summary.

## Usage

The following is an example of how to use this action.

```yaml
name: Lint Codebase

on:
  push:
    branches: [main]

permissions:
  statuses: write

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: pako-23/action-linters@v0.0.1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          HADOLINT: true
          YAMLLINT: true
```

## Required Permissions

The `GITHUB_TOKEN` must be passed as an environment variable to post
commit statuses via the GitHub API. It follow that the action requires
the **`checks: write`** permission to create create commit statuses
(success/error) for each linter run.

## Linters

| Environment Variable | Linter       | Description                       |
|----------------------|--------------|-----------------------------------|
| `ACTIONLINT`         | actionlint   | Lints GitHub Actions Workflows    |
| `ANSIBLE_LINT`       | ansible-lint | Lints Ansible playbooks and roles |
| `HADOLINT`           | hadolint     | Lints Dockerfiles                 |
| `MARKDOWNLINT`       | markdownlint | Lints Markdown files              |
| `YAMLLINT`           | yamllint     | Lints YAML files                  |

Set a variable to `true` to enable the corresponding linter. Omitted
or unset variables disable the linter.

## License

[MIT](LICENSE)
