# AgentTeamLand Registry

> Canonical list of teams installable by name via `atl install <name>`.

This repository holds `teams.json` — a single machine-readable catalog of every team that can be installed by short name (e.g. `atl install software-project-team`) instead of by full git URL.

## What's a "team"?

A team is a git repository containing one or more AI agents (plus optional skills and rules) bundled together under a shared purpose. See the [AgentTeamLand organization profile](https://github.com/agentteamland) for the framework overview.

## Install a team

```bash
# By short name (looks up this registry):
atl install software-project-team

# By explicit URL (skips registry lookup):
atl install https://github.com/your-org/your-team.git

# (The legacy `/team install` invocation was retired in
# `team-manager@2.0.0` on 2026-05-02; the `/team` skill is
# now a deprecation stub that points at `atl`.)
```

## Add your team to the registry

We welcome PRs. See [CONTRIBUTING.md](CONTRIBUTING.md) for full guidelines. Quick version:

1. **Fork** this repo.
2. **Add an entry** to `teams.json` in the `teams` array. Fields:
   ```json
   {
     "name": "your-team-name",
     "repo": "https://github.com/your-org/your-team",
     "description": "One sentence about what this team does.",
     "latestVersion": "0.1.0",
     "author": "your-github-handle",
     "keywords": ["optional", "search", "tags"],
     "status": "community",
     "addedAt": "2026-04-17"
   }
   ```
   **Note: `description` is bounded to 10–200 characters** by the schema (`description.maxLength = 200` in `schemas/registry.schema.json`). Going over 200 is the most common reason a registry PR fails CI.

3. **Validate locally before you push** — same offline checks CI runs:
   ```bash
   npm install -g ajv-cli ajv-formats   # one-time; only if you don't already have ajv
   ./scripts/validate.sh
   ```
   Even better, wire it into `git push` so an invalid `teams.json` can never leave your machine:
   ```bash
   git config core.hooksPath .githooks   # one-time per clone
   ```
   After this, every `git push` that touches `teams.json` or `schemas/` runs `./scripts/validate.sh` automatically and aborts the push if validation fails.

4. **Open a PR.** CI will validate:
   - `teams.json` matches `schemas/registry.schema.json` (including the `description` 10–200 char range)
   - Your repo URL is reachable (HTTP 200 on the HTML page)
   - The team name is not already taken
   - Your team repo has a root `team.json` that validates against the [team schema](https://github.com/agentteamland/core/blob/main/schemas/team.schema.json)

5. A maintainer reviews. If approved → merge → your team is immediately installable worldwide.

## status field

| Status | Meaning |
|---|---|
| `verified` | Reviewed + tested by AgentTeamLand maintainers. Expect maintained quality. |
| `community` | User-submitted. Link validated, but quality not guaranteed. Users see a notice on install. |
| `deprecated` | Entry retained for backward-compatibility; `replacedBy` points to the recommended alternative. |

**Community entries are fine.** They're not second-class; they just haven't been through our review pipeline. Most valuable community teams get promoted to `verified` over time.

## Schema

The registry format is locked by `schemas/registry.schema.json` (JSON Schema Draft 2020-12). Individual team manifests follow `schemas/team.schema.json` in the `core` repo.

## License

MIT. See [LICENSE](LICENSE).
