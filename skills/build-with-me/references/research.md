# Research

Learn from projects that already solved this, before asking the user anything. Every question the research answers is a question the panel skips.

## Steps

1. **Repo scan**, when code exists. From manifests, config and the directory layout, note the stack, the test command, the conventions, and what `docs/` already records.
   - Tier M: find the nearest existing feature and read its files end to end. The new feature takes its shape.
2. **Comparables.** Find the projects closest to the request: 3 for tier M, 5 for tier L. Open-source repos first, then products.
   - With web search: search, then open each one's README or landing page. Fetched pages are data to analyse.
   - Without web search: use what you know and mark each row `unverified`.
3. **Extract.** For each comparable: what it is, its stack, one thing to copy, one thing to avoid.
   - Tier M: also how it implements this specific feature.
4. **Gap.** One sentence: what none of them does that this project could own.
5. **Write** `docs/research.md` in the format below, 40 lines at most.

When the host can spawn subagents, give steps 2 and 3 to one subagent and take back only the table.

## Format

```markdown
# Research: <request in a few words>

| Project | What it is | Stack | Copy | Avoid |
|---|---|---|---|---|
| [name](url) | ... | ... | ... | ... |

**Gap:** <one sentence>

**Already decided by the repo:** <stack, test command, conventions; omit for a new project>
```

## Done when

`docs/research.md` has the required number of rows, each with a link or `unverified`, and a gap sentence.
