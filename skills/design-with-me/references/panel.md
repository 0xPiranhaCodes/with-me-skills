# Panel

A panel of personas reads the research and asks the user everything in one round. Each persona is a lens defined in its own file.

| Persona | File | Joins at tier M when the change touches |
|---|---|---|
| CEO | `persona-ceo.md` | scope, users, pricing |
| CTO | `persona-cto.md` | data model, a new dependency, an integration, a public API |
| Principal Designer | `persona-designer.md` | anything a user sees or types |
| Brand Manager | `persona-brand.md` | naming or user-facing copy |
| Principal SDET | `persona-sdet.md` | always |

Tier L seats all five. The Principal Engineer and the Reviewer ask nothing up front; they join at the build and review steps.

## Steps

1. **Seat** the personas for the tier.
2. **Brief each persona.** It reads the request, `docs/research.md`, and `docs/brief.md` if present, then its own file, and returns at most 150 words:
   - up to 3 concerns;
   - its questions, each with a recommended answer and a one-line reason.

   One question holds one decision and takes one answer; each decision counts against the cap. A question earns its place only when the answer changes what gets built. Whatever the research, the repo or the brief already answers is written as an assumption.
   - Tier L, and the host can spawn subagents: one subagent per persona, in parallel. Give each the request, the path to its persona file, and the path to `docs/research.md`.
   - Otherwise: run the personas one after another in this context, same 150-word limit.
3. **Merge.** Drop duplicates, order by how much rework a wrong answer would cost, and cut to the tier's cap. A question joined by "and" is two questions: split it, or make one half an assumption. Each cut question becomes an assumption with its recommended answer.
4. **Ask once.** Use the host's question tool when it has one; otherwise a numbered list. Show the recommended answer on every question and say that replying `ok` accepts them all.
5. **Record** answers and assumptions in `docs/brief.md` (format in `docs.md`).

## Done when

Every question is answered or defaulted, and `docs/brief.md` holds each answer and each assumption.
