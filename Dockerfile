FROM alpine:3.24

LABEL org.opencontainers.image.description="A collection of linters to run within a GitHub action"

WORKDIR /
COPY requirements.txt package.json package-lock.json /

RUN apk add --no-cache \
    'github-cli~=2.97' \
    'npm~=11.12' \
    parallel=20260322-r0 \
    'py3-pip~=26' \
    'wget~=1.25' && \
    pip3 install --no-cache-dir --break-system-packages -r requirements.txt && \
    wget -qO /usr/local/bin/hadolint https://github.com/hadolint/hadolint/releases/latest/download/hadolint-Linux-x86_64 && \
    chmod +x /usr/local/bin/hadolint && \
    wget -qO /tmp/actionlint.tar.gz https://github.com/rhysd/actionlint/releases/download/v1.7.12/actionlint_1.7.12_linux_amd64.tar.gz && \
    tar xzf /tmp/actionlint.tar.gz -C /usr/local/bin/ actionlint && \
    npm ci && ln -s /node_modules/.bin/markdownlint /usr/local/bin/markdownlint && \
    rm requirements.txt package.json package-lock.json

COPY scripts/linters/ /usr/local/bin/linters/
COPY scripts/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
