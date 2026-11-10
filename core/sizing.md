# Sizing

Size the task before anything else. The tier sets how much research, how many questions, and which docs.

| Tier | When | Research | Panel | Questions | Docs |
|---|---|---|---|---|---|
| **S** | A bug, or a change that needs no new decision | none | none | up to 3, only when blocked | none |
| **M** | A feature in an existing project | repo scan + 3 comparables | personas the change touches | up to 5 | update `docs/brief.md`; an ADR only for a hard-to-reverse decision |
| **L** | A new project, or a change that replaces the architecture | repo scan + 5 comparables | all personas | up to 12 | brief, ADRs, `ARCHITECTURE.md`, `README.md` |

Between two tiers, take the smaller. Move up one tier the moment a hard-to-reverse decision appears (data model, stack, public API, pricing).

State the tier in one line, then continue without waiting:

> Tier M: adds a feature to an existing project. Say S or L to change it.

A tier the user names always wins.
