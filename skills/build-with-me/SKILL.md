---
name: build-with-me
description: Builds a feature or a new project end to end. Sizes the task, researches comparable projects, has a persona panel ask its questions once, records the decisions, then implements test-first and reviews. Use when the user wants something built, added or scaffolded.
license: MIT
---

# build-with-me

Build what the user asked for, with effort scaled to the task. Read each reference only when you reach its step.

Start by reading `docs/brief.md` if it exists. Its answers are settled.

## Steps

1. **Size.** Follow `references/sizing.md`.
   - Done when the tier is stated in one line.
2. **Route tier S.** A bug: follow `references/debug-loop.md` and finish there. Any other small change: go to step 6.
3. **Research.** Follow `references/research.md`.
   - Done when `docs/research.md` exists.
4. **Panel.** Follow `references/panel.md`.
   - Done when every answer and assumption is in `docs/brief.md`.
5. **Docs.** Follow `references/docs.md`, and `references/stack.md` when a stack has to be chosen.
   - Done when every artifact for the tier exists.
6. **Build.** Follow `references/build-loop.md`.
   - Done when every acceptance criterion has a passing test.
7. **Review.** Review the full diff as `references/persona-reviewer.md`.
   - Done when every finding is fixed or listed for the user.

Finish with what was built, how to run it, and any finding left for the user.
