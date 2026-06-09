FROM alpine:3.20

RUN apk add --no-cache \
    github-cli \
    parallel \
    py3-pip \
    wget \
    yamllint

RUN pip3 install --no-cache-dir --break-system-packages ansible-lint

RUN wget -qO /usr/local/bin/hadolint \
    https://github.com/hadolint/hadolint/releases/latest/download/hadolint-Linux-x86_64 \
    && chmod +x /usr/local/bin/hadolint


COPY scripts/linters/ /usr/local/bin/linters/
COPY scripts/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
