# Build loop

Build in vertical slices: each one runs end to end and shows the user something working.

## Steps

1. **Slice.** Split the work into slices, each small enough to finish in one session, and write them to `docs/slices.md` as a checklist. The first is a tracer bullet: the thinnest path through every layer.
   - Resuming: start at the first unticked slice.
   - Tier S: one slice, no ledger.
   - Tier L: the first slice also sets up the project, the test runner, and the run command in `README.md`.
2. **For each slice:**
   1. Write its acceptance criteria as the SDET (`persona-sdet.md`).
   2. Take one criterion and write its test. Watch it go red for the right reason: it fails on the assertion, with the expected message. A test that passes at once is testing existing behaviour; rewrite it.
   3. Turn it green as the Principal Engineer (`persona-engineer.md`), then return to 2 for the next criterion.
   4. Run the full test command and read its output. For a slice with a UI, when the host has a browser tool, walk the slice's flow in the browser too.
   5. Tick the slice in `docs/slices.md`.
3. **Drift.** When the code has to contradict an ADR, stop, write the ADR that supersedes it, then continue.

Commit when the user asks for commits.

## Done when

Every slice is ticked, every acceptance criterion has a passing test, and the last full test run is green.
