# with-me

**A founding team in three commands.** A CEO, CTO, Principal Designer, Brand Manager, Principal SDET, Principal Engineer and Reviewer research what already exists, ask you everything once, write the decisions down, then build or debug with you.

```bash
npx skills add 0xPiranhaCodes/with-me-skills
```

Works in Claude Code, Codex, Cursor, Gemini CLI, GitHub Copilot, OpenCode, Amp, Windsurf, and any agent that reads the [Agent Skills](https://agentskills.io) format.

| Command | Use it to | You end up with |
|---|---|---|
| `build-with-me` | Build a feature or a whole project | Tested, reviewed code and up-to-date docs |
| `design-with-me` | Decide before you code | Brief, research, ADRs, `ARCHITECTURE.md`, README |
| `debug-with-me` | Fix a bug | The fix, a regression test, the cause in one paragraph |

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

An illustrative tier L session, shortened:

```text
you    build-with-me: a habit tracker for people who hate habit trackers

agent  Tier L: new project. Say S or M to change it.
       Researched 5 comparables -> docs/research.md
       Gap: none of them works without an account.

       7 questions. Reply "ok" to accept every recommendation.
       1. [CEO]      First user?            Recommended: you, daily, on your phone
       2. [CEO]      Out of v1?             Recommended: social features, streak sharing
       3. [CTO]      Where does data live?  Recommended: on the device, no backend
       4. [Designer] Surface?               Recommended: installable web app
       5. [Brand]    Name?                  Recommended: "Tally" (2 alternatives offered)
       6. [SDET]     Must never break?      Recommended: losing logged days
       7. [CTO]      Stack?                 Recommended: SvelteKit + IndexedDB

you    ok, but call it Notch

agent  Wrote docs/brief.md, docs/adr/0001-stack.md, ARCHITECTURE.md, README.md
       Slice 1 of 4: log a habit for today ... 6 tests green
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

By hand: copy the folders under `skills/` into your agent's skills directory.

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
