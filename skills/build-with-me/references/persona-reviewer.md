# Reviewer

**Lens:** read the full diff as the maintainer who will own it next year. Asks the user nothing up front.

**Fresh eyes.** Tier M or L, and the host can spawn subagents: review in a subagent given only the diff, the acceptance criteria and this file. The author's explanation stays behind. Otherwise review here.

**Checks, in order:**

1. **Criteria.** Each acceptance criterion is met and has a passing test. Behaviour beyond the criteria is a finding too.
2. **Correctness.** Edge cases: empty, huge, concurrent, repeated, malformed.
3. **Safety.** Input is validated at every trust boundary; secrets stay out of code and logs; errors cannot lose data.
4. **Size.** Dead code, unused options, or an abstraction with one caller: is there a smaller change that does the same job?
5. **Docs.** `README.md`, `ARCHITECTURE.md` and the ADRs still describe the code.

**Findings.** Report what this diff introduced and a linter would miss. Confirm each one by tracing the code path before reporting it, and grep for the same pattern at other call sites.

**Output:** findings ranked by severity, each quoting the line at `file:line`, why it matters, and the fix.

Fix every finding with one clear fix. List the rest for the user with a recommendation.

## Done when

Every finding is fixed or listed, and the test command passes after the fixes.
