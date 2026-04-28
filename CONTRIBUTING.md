# Contributing to AgentTeamLand Registry

Thank you for wanting to add your team! This guide walks you through the PR process.

## Before you submit

Your team repo must have:

- A root `team.json` that validates against [the team schema](https://github.com/agentteamland/core/blob/main/schemas/team.schema.json)
- A clear README describing what the team does, its agents, and how to use them
- A `LICENSE` file (MIT / Apache-2.0 / ISC recommended — match what you set in `team.json`)
- At least one public release tag (SemVer, e.g. `v0.1.0`)

## Step-by-step

### 1. Fork and branch

```bash
gh repo fork agentteamland/registry --clone
cd registry
git checkout -b add-<your-team-name>
```

### 2. Add your entry

Open `teams.json` and add your entry to the `teams` array:

```json
{
  "name": "your-team-name",
  "repo": "https://github.com/your-org/your-team",
  "description": "One sentence \u2014 what this team does.",
  "latestVersion": "0.1.0",
  "author": "your-github-handle",
  "authorUrl": "https://your-site.example",
  "keywords": ["keyword-1", "keyword-2"],
  "homepage": "https://github.com/your-org/your-team",
  "status": "community",
  "addedAt": "2026-04-17"
}
```

**Field guidance:**

- `name` — kebab-case, 3-40 chars, must be unique in the registry. Must match the `name` field in your repo's `team.json`.
- `repo` — HTTPS GitHub URL (we'll support other hosts later).
- `description` — 10-200 characters. One sentence. Sentence case, no trailing period required but fine.
- `latestVersion` — SemVer. Should match the latest release tag on your repo.
- `author` — your GitHub handle (or organization slug).
- `keywords` — up to 20 tags, lowercase recommended. Help people find you in search.
- `status` — always start with `"community"`. Maintainers promote to `"verified"` after review.
- `addedAt` — the date you open the PR (ISO `YYYY-MM-DD`).

### 3. Validate locally (strongly recommended)

A helper script runs the same offline checks the CI runs:

```bash
npm install -g ajv-cli ajv-formats   # one-time, only if you don't have ajv
./scripts/validate.sh
```

**Even better — wire it into `git push` so you can never push an invalid `teams.json`:**

```bash
git config core.hooksPath .githooks   # one-time per clone
```

After this, every `git push` that touches `teams.json` or `schemas/` runs `./scripts/validate.sh` and aborts the push if validation fails. The most common failure is the `description` field exceeding 200 characters — `description.maxLength = 200` in [schemas/registry.schema.json](schemas/registry.schema.json). Catch it locally instead of in a failed PR check.

### 4. Commit and open a PR

```bash
git add teams.json
git commit -m "registry: add <your-team-name>"
git push origin add-<your-team-name>
gh pr create --fill
```

### 5. CI runs

Our GitHub Actions workflow checks:

- `teams.json` validates against the schema
- Your team's repo URL responds with HTTP 200
- Your team's `team.json` (at `{repo}/raw/main/team.json`) validates against the team schema
- The `name` is not duplicated in `teams.json`

### 6. Review

A maintainer reviews for:

- **Clarity** — description is understandable and accurate
- **License** — your repo has a proper LICENSE file
- **Safety** — no obvious malicious code, no plagiarism from other registry entries
- **Keywords** — they're relevant, not spammy

Turnaround is usually a few days. If we need changes, we'll comment on the PR.

### 7. Merge

Once merged, your team is immediately installable from any project with:

```bash
/team install your-team-name
```

## Promoting to verified

After 3+ months in the registry with no unresolved issues, you can open an issue requesting `verified` status. We'll re-review and promote if it meets our quality bar.

Verified teams get:

- A badge in the registry listing
- Featured placement on the AgentTeamLand org profile
- No "community team — review before using" notice on install

## Updating your entry

To update `latestVersion`, `description`, `keywords`, etc., open a PR editing your entry. Same CI runs. Fast merges for minor fixes.

## Removing your entry

To remove your team from the registry, open a PR deleting your entry (or set `status: "deprecated"` with `deprecatedReason` if you want to signal that users should move elsewhere).

## Questions?

Open an issue on this repo. We're happy to help you get listed.
