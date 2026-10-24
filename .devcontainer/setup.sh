#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

# Keep runtime secrets and local database settings out of Git.
if [ ! -f .env ]; then
  umask 077
  printf 'PORT=3001\nHOST=0.0.0.0\nENCRYPTION_KEY=%s\n' "$(node -e "process.stdout.write(require('node:crypto').randomBytes(32).toString('hex'))")" > .env
else
  grep -q '^ENCRYPTION_KEY=' .env || printf 'ENCRYPTION_KEY=%s\n' "$(node -e "process.stdout.write(require('node:crypto').randomBytes(32).toString('hex'))")" >> .env
  grep -q '^PORT=' .env || printf 'PORT=3001\n' >> .env
  if grep -q '^HOST=' .env; then
    sed -i 's/^HOST=.*/HOST=0.0.0.0/' .env
  else
    printf 'HOST=0.0.0.0\n' >> .env
  fi
fi

npm ci
