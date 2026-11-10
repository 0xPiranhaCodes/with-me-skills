# Build loop

Build in vertical slices: each one runs end to end and shows the user something working.

## Steps

1. **Slice.** Split the work into slices and show the user the list. The first is a tracer bullet: the thinnest path through every layer.
   - Tier L: the first slice also sets up the project, the test runner, and the run command in `README.md`.
2. **For each slice:**
   1. Write its acceptance criteria as the SDET (`persona-sdet.md`).
   2. Write the tests and watch them go red.
   3. Turn them green as the Principal Engineer (`persona-engineer.md`).
   4. Run the full test command and read its output.
3. **Drift.** When the code has to contradict an ADR, stop, write the ADR that supersedes it, then continue.

Commit when the user asks for commits.

## Done when

Every acceptance criterion has a passing test, and the last full test run is green.
