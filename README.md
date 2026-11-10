# with-me

[![check](https://github.com/0xPiranhaCodes/with-me-skills/actions/workflows/check.yml/badge.svg)](https://github.com/0xPiranhaCodes/with-me-skills/actions/workflows/check.yml)

**A founding team in three commands.** A CEO, CTO, Principal Designer, Brand Manager, Principal SDET, Principal Engineer and Reviewer research what already exists, ask you everything once, write the decisions down, then build or debug with you.

```bash
npx skills add 0xPiranhaCodes/with-me-skills
```

Plain [Agent Skills](https://agentskills.io) files, so the same install serves Claude Code, Codex, Cursor, Gemini CLI, GitHub Copilot, OpenCode, Amp and Windsurf. See [Status](#status) for what has been tested.

| Command | Use it to | You end up with |
|---|---|---|
| `build-with-me` | Build a feature or a whole project | Tested, reviewed code and up-to-date docs |
| `design-with-me` | Decide before you code | Brief, research, ADRs, `ARCHITECTURE.md`, README |
| `debug-with-me` | Fix a bug | The fix, a regression test, the cause in one paragraph |

## Quick start

Install, open your agent in a project folder (an empty one is fine), and say what you want:

```text
/build-with-me a habit tracker for people who hate habit trackers
/build-with-me let me archive a habit instead of deleting it
/design-with-me a CLI that syncs dotfiles between machines
/debug-with-me the longest streak shows 2 but I checked in five days in a row
```

That is the Claude Code form. In other agents, name the skill in your request: `use build-with-me to add CSV export`.

Then answer one round of questions, or reply `ok` to take every recommendation. On a new project it shows you the design and waits for `go` before writing code. Come back later with `/build-with-me continue`.

What it writes into your repo, besides the code and tests:

```text
docs/research.md    comparable projects, what to copy and avoid, the gap
docs/brief.md       problem, scope, and every answer and assumption
docs/adr/           one short file per hard-to-reverse decision
docs/slices.md      the work as a checklist; a new session resumes from it
ARCHITECTURE.md     components, data model, core flow, test strategy
README.md           name, pitch, install, quick start
```

## Why another skill pack

**Effort scales with the task.** A bug fix should not get a product requirements document. Every run starts by sizing the work:

| Tier | When | Research | Questions | Docs |
|---|---|---|---|---|
| **S** | Bug or small change | none | up to 3, only when blocked | none |
| **M** | Feature in an existing project | your repo + 3 comparable projects | up to 5 | an ADR only for a hard-to-reverse decision |
| **L** | New project | 5 comparable projects | up to 12 | brief, ADRs, architecture, README |

**Research comes before questions.** The panel first looks at projects that already solved your problem: what to copy, what to avoid, and the gap you could own. Anything the research answers is a question you are never asked.

**One round of questions, each with a recommended answer.** Reply `ok` to accept them all.

**Decisions and progress live on disk.** Answers go to `docs/brief.md` and ADRs, and the work is a checklist in `docs/slices.md`, so the next session asks nothing twice and resumes at the first unticked slice.

**Tests that prove something, reviews with fresh eyes.** One test at a time, each seen failing for the right reason before any code. The review runs in a separate context that sees only the diff and the acceptance criteria, where the agent supports it.

**Shipping on request.** Ask to commit, open a pull request or release, and it syncs with the default branch, re-runs the tests, and writes the commit and pull request in your repo's style. Merging, tagging and deploying wait for your go-ahead.

**The cost is published.** Each skill is a short router that loads one small file per step. This is what a run reads, measured by `scripts/check.sh` at roughly 4 characters per token:

| Run | Approx. tokens loaded |
|---|---|
| Three descriptions, always in context | 171 |
| debug-with-me, a bug | 1353 |
| build-with-me, tier S change | 1918 |
| build-with-me, tier M with 3 personas | 3660 |
| build-with-me, tier L, everything | 4234 |
| Shipping, added only when you ask | 268 |
| design-with-me, tier L | 3099 |

These are instruction tokens only. The work itself (research, code, tests) costs what it costs.

## What a run looks like

A real session, shortened: the `new-project` [golden scenario](evals/README.md) run with Claude Sonnet.

```text
you    /build-with-me a habit tracker for people who hate habit trackers

agent  Tier L: a new project, so the full process applies. Say S or M to change it.
       Wrote docs/research.md (5 comparables).
       Gap: none treats "I will quit this app" as the main failure mode.

       9 questions. Reply "ok" to accept them all, or give changes by number.
       1. [CEO]      Who is the first user?    Recommended: you, and people who quit other trackers
       2. [CEO]      What makes v1 a success?  Recommended: still opened after 30 days, without guilt
       3. [CEO]      Out of v1?                Recommended: streaks, points, social, notifications, accounts
       4. [CEO]      Who pays?                 Recommended: free and open source, no monetisation in v1
       6. [Designer] Core flow?                Recommended: one tap per habit, a missed day is just blank
       7. [Designer] Visual direction?         Recommended: warm paper, ink, moss; an index-card column
       ...

you    ok, but call it Notch

agent  Wrote docs/brief.md, two ADRs, ARCHITECTURE.md and README.md. Nothing is built yet.
       Design summary: (8 lines)
       Reply "go" to start the build, or tell me what to change.

you    go, but stop after the first slice so I can take a look

agent  Slice 1 is done and I've stopped there. You can add a habit, tap to mark today,
       see "N of 14", and your data survives a reload.
       5 of 5 criteria ticked in docs/slices.md; npm test: 5 pass, 0 fail.
       I walked the flow in a real browser. Say "continue" for slice 2.
```

## The panel

| Persona | Cares about | Owns |
|---|---|---|
| CEO | Who it is for, the smallest version that proves it | Problem, scope, non-goals |
| CTO | The simplest architecture that survives year one | Stack, ADRs, `ARCHITECTURE.md` |
| Principal Designer | A new user finishing the core flow unaided | Core flow, empty and error states |
| Brand Manager | A stranger getting it in five seconds | Name, pitch, README voice |
| Principal SDET | Every behaviour having a test that can fail | Acceptance criteria, regression tests |
| Principal Engineer | The smallest complete change that fits the codebase | The implementation of every slice and fix |
| Reviewer | The diff, as next year's maintainer | Final review |

Agents that support subagents run the panel in parallel on a new project, and the Reviewer in its own context on features and new projects. Everywhere else it all runs in one conversation.

## Install

Any agent:

```bash
npx skills add 0xPiranhaCodes/with-me-skills
```

Claude Code plugin:

```text
/plugin marketplace add 0xPiranhaCodes/with-me-skills
/plugin install with-me@with-me
```

By hand: copy the folders under `skills/` into your agent's skills directory (`.claude/skills` for Claude Code, `.agents/skills` for most others).

## Status

Version 0.1. What has and has not been exercised:

- **Tested:** all four [golden scenarios](evals/README.md) (a bug, a new project, a resume, a feature) pass with Claude Sonnet.
- **Not yet tested:** other agents and models. They read the same files; reports and fixes are welcome.
- **Depends on your agent's tools:**
  - Web search: without it the research still runs, from the model's own knowledge, and marks every comparable `unverified`.
  - Subagents: needed for the parallel panel and the separate-context review. Without them everything runs in one conversation.
  - A browser tool: needed for the click-through of UI slices.

## Contributing

The source of truth is `core/`. Each skill carries a generated copy of the files it needs, so it installs on its own.

```bash
sh scripts/sync.sh    # after editing core/
sh scripts/check.sh   # size limits, sync drift, and the token table above
```

A change to how the skills behave should still pass the four golden scenarios in [`evals/`](evals/README.md): a bug, a new project, a resume and a feature, each with a fixture, a scripted conversation and a checker.

Limits that keep it cheap: 60 lines per `SKILL.md`, 80 per reference file, 300 characters per description. A change that raises the token table needs a reason in the pull request.

## License

MIT
