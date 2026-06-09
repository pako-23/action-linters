FROM alpine:3.20

RUN apk add --no-cache \
    'github-cli~=2.47' \
    parallel=20240422-r0 \
    'py3-pip~=24' \
    'wget~=1.24' \
    'yamllint~=1.35' && \
    pip3 install --no-cache-dir --break-system-packages ansible-lint>=1.38 && \
    wget -qO /usr/local/bin/hadolint \
    https://github.com/hadolint/hadolint/releases/latest/download/hadolint-Linux-x86_64 \
    && chmod +x /usr/local/bin/hadolint

COPY scripts/linters/ /usr/local/bin/linters/
COPY scripts/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
