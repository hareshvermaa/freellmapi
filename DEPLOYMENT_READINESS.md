# FreeLLMAPI deployment readiness checklist

This file tracks what must be verified before this fork is considered ready to run.

## Repository and runtime
- [ ] Install dependencies with `npm ci` on a clean Linux environment using a supported Node.js version (20.18+ and below 25).
- [ ] Run the project's existing CI workflow: migration round-trip, test suites, lint, and workspace builds.
- [ ] Verify the production Docker image builds and starts with a persistent data volume.
- [ ] Verify the container health check at `/api/ping`.
- [ ] Verify the dashboard and the OpenAI-compatible `/v1/models` endpoint are reachable.
- [ ] Verify a chat-completions request succeeds after the owner configures at least one legitimate provider API key.
- [ ] Verify restart persistence for the database and encryption key.
- [ ] Confirm secrets are only configured in the host's secret manager/environment and are not committed to Git.

## Hosting requirements
GitHub stores the source and can run CI, but it is not an always-on application server. A production deployment requires a host that runs the Docker image (or Node.js process), a persistent volume for `server/data`, and persistent `ENCRYPTION_KEY` configuration.

Do not expose an unclaimed dashboard or the single-user API to the public internet. Complete first-run account setup securely, configure TLS/access controls, and use provider keys you are authorized to use.

## Current status
This checklist is a plan, not a claim that any unchecked step has passed. Mark items complete only after evidence from an actual workflow run or deployment test is available.
