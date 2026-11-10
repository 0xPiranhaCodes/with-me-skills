# Debug loop

Fix the cause once, and leave a test that would have caught it.

## Steps

1. **Read.** The error, the stack trace, the failing code, and recent changes (`git log`, `git diff`). Ask the user up to 3 questions, only for what looking cannot answer: exact steps, expected versus actual, when it last worked.
2. **Reproduce.** Build a tight loop that goes red on the bug: a failing test, or one command when a test is impractical.
   - Done when it fails for the reported reason, every time.
3. **Root cause.** Trace back from the symptom to the first wrong value. State the cause in one sentence with `file:line`. Find every caller of the faulty code.
   - After two wrong hypotheses, gather evidence instead of guessing again: bisect, or add logging at the boundary where the value turns wrong.
4. **Fix** at the cause, once, in the shared code.
5. **Verify.** The loop is green and the full test command is green. Keep the loop as the regression test (`persona-sdet.md`).
6. **Review** the diff as the Reviewer (`persona-reviewer.md`).
7. **Report** in one paragraph: the cause, the fix, the test.

When the real fix is a redesign, stop after step 3, say so, and offer `build-with-me`.

## Done when

The regression test failed before the fix, passes after it, and the full test run is green.
