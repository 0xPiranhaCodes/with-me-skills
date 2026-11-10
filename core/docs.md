# Docs

Write the artifacts the tier calls for (the Docs column in `sizing.md`). `docs/` is the project's memory: a later session reads it and asks nothing it already answers. Edit a file that exists; create only what is missing.

## `docs/brief.md`

```markdown
# Brief: <name>
## Problem
## User
## Scope (v1)
## Non-goals
## Core flow
## Decisions
- <question> -> <answer>
## Assumptions
- <assumption> (change it by saying so)
```

## `docs/adr/NNNN-<title>.md`

One ADR per decision that is hard to reverse and had a real alternative. 25 lines at most.

```markdown
# NNNN. <decision as a sentence>
Status: accepted | superseded by NNNN
## Context
## Decision
## Alternatives considered
## Consequences
```

## `ARCHITECTURE.md`

- **Overview:** one paragraph.
- **Components:** each with its single responsibility.
- **Data model:** entities and relations.
- **Core flow:** a Mermaid sequence or flow diagram of the flow in the brief.
- **Test strategy:** from the SDET.
- **Run it:** install, run and test commands.

## `README.md`

Top from the Brand Manager: name, tagline, pitch. Then install, a quick start that works when pasted, a link to `ARCHITECTURE.md`, contributing, license.

## Done when

Every artifact for the tier exists, and each decision in `docs/brief.md` that is hard to reverse has an ADR.
