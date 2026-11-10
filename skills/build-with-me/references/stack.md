# Stack

Recommend one stack and one alternative. Apply these criteria in order; an earlier one beats a later one.

1. **What the repo already uses.**
2. **What the user knows** (the CTO's first question).
3. **What the comparables converge on** in `docs/research.md`.
4. **Boring and well documented:** a large ecosystem means fewer surprises and better agent-written code.
5. **Cheapest at zero users:** free tier or a single small machine.
6. **Fewest moving parts:** one language, one deploy target, one datastore.

Confirm current versions from the package registry or official docs when the host can reach them.

## Output

Show the user this table, with the alternative in one line beneath it:

| Layer | Choice | Why | Tradeoff |
|---|---|---|---|

Record the accepted stack as `docs/adr/0001-stack.md`.

## Done when

The user accepted a stack and ADR 0001 records it with the alternative considered.
