#!/bin/sh
# Golden checks on what a scenario run left on disk. Transcript-only expectations are in evals/README.md.
# usage: sh evals/check.sh <bug|new-project|resume|feature> <directory>
#        sh evals/check.sh fixtures          (sanity-check the fixtures themselves; runs in CI)
set -u
here=$(cd "$(dirname "$0")" && pwd)
scenario=${1:?usage: check.sh <bug|new-project|resume|feature|fixtures> [directory]}
dir=${2:-}
fx=$here/fixtures
fail=0

check() { # check "<description>" command...
  desc=$1
  shift
  if "$@" > /dev/null 2>&1; then echo "ok    $desc"; else echo "FAIL  $desc"; fail=1; fi
}
not() { ! "$@"; }
tests_pass() { (cd "$1" && npm test); }
test_count() { (cd "$1" && npm test 2> /dev/null | sed -n 's/^# tests //p'); }
more_tests_than() { [ "$(test_count "$1")" -gt "$2" ]; }
unticked() { grep -q "^- \[ \] $2\. " "$1/docs/slices.md"; }
ticked() { grep -q "^- \[x\] $2\. " "$1/docs/slices.md"; }

# Golden outputs for the streak bug, independent of whatever test the agent wrote.
streak_golden() {
  node --input-type=module -e '
    import assert from "node:assert/strict";
    const { longestStreak } = await import(process.argv[1] + "/src/streak.js");
    assert.equal(longestStreak(["2026-03-01","2026-03-01","2026-03-02","2026-03-03","2026-03-03","2026-03-04","2026-03-05"]), 5);
    assert.equal(longestStreak(["2026-03-01","2026-03-02","2026-03-05"]), 2);
    assert.equal(longestStreak(["2026-03-02","2026-03-01"]), 2);
    assert.equal(longestStreak([]), 0);
  ' "$1"
}
# The agent's tests must fail when the original buggy source is put back.
regression_guards_fix() {
  tmp=$(mktemp -d)
  cp -R "$1/." "$tmp"
  cp "$fx/streaks/src/streak.js" "$tmp/src/streak.js"
  if tests_pass "$tmp"; then r=1; else r=0; fi
  rm -rf "$tmp"
  return $r
}
research_rows_at_least() { # table rows minus header and separator
  [ $(($(grep -c '^|' "$1/docs/research.md") - 2)) -ge "$2" ]
}
decisions_kept() { # every decision line already in the fixture brief is still there
  grep -- ' -> ' "$fx/notch/docs/brief.md" | while IFS= read -r line; do
    grep -Fxq -- "$line" "$1/docs/brief.md" || exit 1
  done
}
research_grew() { [ "$(wc -l < "$1/docs/research.md")" -gt "$(wc -l < "$fx/notch/docs/research.md")" ]; }

case $scenario in
  fixtures)
    check "streaks fixture: its own tests pass" tests_pass "$fx/streaks"
    check "streaks fixture: the bug is present" not streak_golden "$fx/streaks"
    check "notch fixture: tests pass" tests_pass "$fx/notch"
    check "notch fixture: slice 2 is the first unticked slice" unticked "$fx/notch" 2
    ;;
  bug)
    : "${dir:?directory required}"
    check "tests pass" tests_pass "$dir"
    check "a test was added" more_tests_than "$dir" 3
    check "golden streak outputs are correct" streak_golden "$dir"
    check "the tests fail when the bug is put back" regression_guards_fix "$dir"
    check "no [DBG] line remains" not grep -rqF "[DBG]" "$dir/src" "$dir/test"
    ;;
  new-project)
    : "${dir:?directory required}"
    check "docs/research.md has 5 comparables" research_rows_at_least "$dir" 5
    check "docs/research.md states the gap" grep -q '\*\*Gap:\*\*' "$dir/docs/research.md"
    check "docs/brief.md records decisions" grep -q '^## Decisions' "$dir/docs/brief.md"
    check "docs/brief.md records assumptions" grep -q '^## Assumptions' "$dir/docs/brief.md"
    check "the name override (Notch) reached the brief" grep -q 'Notch' "$dir/docs/brief.md"
    check "the name override (Notch) reached the README" grep -q 'Notch' "$dir/README.md"
    check "the stack ADR exists" test -f "$dir/docs/adr/0001-stack.md"
    check "ARCHITECTURE.md exists" test -f "$dir/ARCHITECTURE.md"
    check "slice 1 is ticked" ticked "$dir" 1
    check "slice 2 is still unticked (stopped as asked)" unticked "$dir" 2
    ;;
  resume)
    : "${dir:?directory required}"
    check "slice 2 is now ticked" ticked "$dir" 2
    check "slice 3 is still unticked (stopped as asked)" unticked "$dir" 3
    check "tests pass" tests_pass "$dir"
    check "tests were added" more_tests_than "$dir" 12
    check "docs/brief.md is unchanged (nothing re-asked)" cmp -s "$dir/docs/brief.md" "$fx/notch/docs/brief.md"
    ;;
  feature)
    : "${dir:?directory required}"
    check "tests pass" tests_pass "$dir"
    check "tests were added" more_tests_than "$dir" 12
    check "earlier decisions are kept in docs/brief.md" decisions_kept "$dir"
    check "docs/brief.md gained the new decisions" not cmp -s "$dir/docs/brief.md" "$fx/notch/docs/brief.md"
    check "docs/research.md gained the feature research" research_grew "$dir"
    check "slice 2 was left alone (stayed in scope)" unticked "$dir" 2
    ;;
  *)
    echo "unknown scenario: $scenario" >&2
    exit 2
    ;;
esac

exit $fail
