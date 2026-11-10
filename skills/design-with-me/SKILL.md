---
name: design-with-me
description: Designs a product or feature before any code. Researches comparable projects, runs a CEO, CTO, designer, brand and SDET panel, then writes the brief, ADRs, architecture and README. Use when the user wants to plan, scope, choose a stack or document a design.
license: MIT
---

# design-with-me

Produce the decisions and documents; the code comes later, from `build-with-me`. Read each reference only when you reach its step.

Start by reading `docs/brief.md` if it exists. Its answers are settled.

## Steps

1. **Size.** Follow `references/sizing.md`.
   - Done when the tier is stated in one line. Tier S needs no design: say so and offer to build it directly.
2. **Research.** Follow `references/research.md`.
   - Done when `docs/research.md` exists.
3. **Panel.** Follow `references/panel.md`.
   - Done when every answer and assumption is in `docs/brief.md`.
4. **Docs.** Follow `references/docs.md`, and `references/stack.md` when a stack has to be chosen.
   - Done when every artifact for the tier exists.

Finish with the decisions made, the files written, and the assumptions the user should check.
