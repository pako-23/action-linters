FROM alpine:3.20

LABEL org.opencontainers.image.description="A collection of linters to run within a GitHub action"

RUN apk add --no-cache \
    'github-cli~=2.47' \
    'npm~=10.9' \
    parallel=20240422-r0 \
    'py3-pip~=24' \
    'wget~=1.24' \
    'yamllint~=1.35' && \
    pip3 install --no-cache-dir --break-system-packages ansible-lint==26.4.0 && \
    wget -qO /usr/local/bin/hadolint https://github.com/hadolint/hadolint/releases/latest/download/hadolint-Linux-x86_64 && \
    chmod +x /usr/local/bin/hadolint && \
    wget -qO /tmp/actionlint.tar.gz https://github.com/rhysd/actionlint/releases/download/v1.7.12/actionlint_1.7.12_linux_amd64.tar.gz && \
    tar xzf /tmp/actionlint.tar.gz -C /usr/local/bin/ actionlint && \
    npm install -g markdownlint-cli

COPY scripts/linters/ /usr/local/bin/linters/
COPY scripts/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
