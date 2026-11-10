# Golden test cases

Four fixed scenarios that every change to `core/` or a `SKILL.md` should still pass. Each has a fixture, a prompt, scripted user replies, and two kinds of expectation:

- **On disk:** checked by `evals/check.sh`.
- **In the transcript:** checked by reading the session, listed under each scenario.

## Running one

```bash
sh scripts/sync.sh                               # install what you just edited
sh evals/setup.sh <scenario> /tmp/golden-run     # fixture + skills, in a new directory
# open a fresh agent session in /tmp/golden-run, send the prompt, then the replies in order
sh evals/check.sh <scenario> /tmp/golden-run
```

Use a new directory and a fresh session for every run. `sh evals/check.sh fixtures` checks the fixtures themselves and runs in CI. The scenarios need Node 20 or later.

## Scenarios

### `bug`: a seeded bug in a small library

- **Fixture:** `fixtures/streaks`. `longestStreak` resets when one day has two check-ins.
- **Prompt:** `debug-with-me: my longest streak shows 2 but I checked in five days in a row last week. I sometimes check in twice a day if that matters`
- **Replies:** none expected. If asked for repro steps: `I don't have exact dates, sorry`.
- **Transcript:**
  - at most 3 questions, none answerable by reading the code;
  - the cause is stated in one sentence with `file:line`;
  - the report names the cause, the fix and the test.

### `new-project`: tier L from an empty directory

- **Fixture:** empty.
- **Prompt:** `build-with-me: a habit tracker for people who hate habit trackers`
- **Replies, in order:**
  1. `ok, but call it Notch`
  2. `go, but stop after the first slice so I can take a look`
- **Transcript:**
  - the tier is stated in one line before anything else;
  - `docs/research.md` is written before the questions;
  - one round of at most 12 questions, one decision each, a recommended answer on every one;
  - after reply 1, no code is written until reply 2 (the approval gate), and the design summary is under 10 lines;
  - the first slice's tests are written one at a time, each failing on its assertion first.

### `resume`: continue an existing project in a fresh session

- **Fixture:** `fixtures/notch`. Slice 1 and a notes feature are done; slice 2 (rename, delete, export) is the first unticked slice.
- **Prompt:** `build-with-me: continue, do the next slice and then stop so I can look`
- **Replies:** none expected.
- **Transcript:**
  - zero questions;
  - no research or panel step; it goes to the build loop;
  - the slice's criteria appear as a checklist and are ticked one test at a time.

### `feature`: tier M on an existing project

- **Fixture:** `fixtures/notch`.
- **Prompt:** `build-with-me: let me archive a habit instead of deleting it`
- **Replies, in order:**
  1. `ok`
- **Transcript:**
  - tier M is stated;
  - one round of at most 5 questions, one decision each, none already answered in `docs/brief.md`;
  - the CEO persona is seated only if the questions touch scope;
  - a new ADR appears only if the data model or another hard-to-reverse choice changed;
  - the review step runs and its findings are fixed or listed.

## Adding a scenario

Add the fixture under `fixtures/`, a case in `setup.sh` and `check.sh`, and a section here. A check belongs in `check.sh` when a script can decide it from the files; everything else goes in the transcript list.
