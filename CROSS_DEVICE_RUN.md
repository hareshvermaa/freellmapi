# FreeLLMAPI — cross-device run

This repository is configured for GitHub Codespaces so the same cloud workspace can be resumed from an office PC, home laptop, or phone browser. Runtime files and the SQLite database stay in the Codespaces workspace rather than on a particular device.

## Start the cloud workspace

Open the repository while signed in to GitHub:
https://github.com/hareshvermaa/freellmapi

Choose **Code → Codespaces** and create/open a Codespace. The checked-in `.devcontainer` configuration installs dependencies, creates a private local `.env` with a persistent encryption key, and starts the dashboard and API automatically. The dashboard is exposed on forwarded port 5173 and the API on port 3001; both are private to the Codespaces owner by default.

When returning from another device, reopen the **same Codespace**, then open its **5173 — FreeLLMAPI Dashboard** port. Do not create a new Codespace for every device: separate Codespaces are separate workspaces and databases.

## Important runtime boundaries

- This is a persistent, resumable development workspace, not an always-on production hosting service. The Codespace can stop when idle and needs to be resumed.
- The API health check only proves the server is running. Real model responses require valid provider keys configured in the dashboard.
- Keep forwarded ports private. Do not make the dashboard or API public without a deliberate security review.
- The `.env`, encryption key, and SQLite database are runtime data and must never be committed to Git.
