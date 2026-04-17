# AgentTeamLand Registry

> Canonical list of teams installable by name via `/team install <name>`.

This repository holds `teams.json` — a single machine-readable catalog of every team that can be installed by short name (e.g. `/team install software-project-team`) instead of by full git URL.

## What's a "team"?

A team is a git repository containing one or more AI agents (plus optional skills and rules) bundled together under a shared purpose. See the [AgentTeamLand organization profile](https://github.com/agentteamland) for the framework overview.

## Install a team

```bash
# By short name (looks up this registry):
/team install software-project-team

# By explicit URL (skips registry lookup):
/team install https://github.com/your-org/your-team.git
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
3. **Open a PR.** CI will validate:
   - `teams.json` matches `schemas/registry.schema.json`
   - Your repo URL is reachable (HTTP 200 on the HTML page)
   - The team name is not already taken
   - Your team repo has a root `team.json` that validates against the [team schema](https://github.com/agentteamland/core/blob/main/schemas/team.schema.json)
4. A maintainer reviews. If approved → merge → your team is immediately installable worldwide.

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
