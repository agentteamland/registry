# 📦 AgentTeamLand Registry

> Single canonical catalog of installable agent teams. Holds `teams.json` — the file `atl install <name>` looks up to resolve a short name to a Git URL.

The registry is the public discovery surface for the AgentTeamLand ecosystem. To list a new team, fork this repo, add an entry to `teams.json`, and open a PR. CI validates schema conformance, repo reachability, and that the team's own `team.json` validates against the [team schema](https://github.com/agentteamland/core/blob/main/schemas/team.schema.json).

The most common reason a registry PR fails CI is the `description` length cap (10–200 chars). The repo ships `./scripts/validate.sh` for local pre-push validation, plus a `.githooks` git-push hook that runs the validator automatically.

## 📚 Documentation

Full docs live at **[agentteamland.github.io/docs](https://agentteamland.github.io/docs/)**.

Most relevant sections:

- [Registry submission](https://agentteamland.github.io/docs/authoring/registry-submission) — full PR walkthrough, schema constraints, local validation, status lifecycle
- [Browse verified teams](https://agentteamland.github.io/docs/teams/) — what's in the registry today
- [`atl install`](https://agentteamland.github.io/docs/cli/install) — the install command this catalog feeds
- [`team.json`](https://agentteamland.github.io/docs/authoring/team-json) — the per-team manifest the registry validates against

## License

MIT. See [LICENSE](LICENSE).
