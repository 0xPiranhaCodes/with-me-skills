# Ship

Runs when the user asks to ship, commit, open a pull request or release.

## Steps

1. **Branch.** Work on a branch; from the default branch, create one first unless the repo's convention or the user says to commit there.
2. **Sync.** Fetch, then bring the default branch into the work branch the way the repo's history shows (rebase or merge).
3. **Verify** after the sync: the full test command, plus lint and build when the repo has them.
4. **Record.** Add a changelog entry when the repo keeps a changelog. Bump the version only for a release the user asked for.
5. **Commit.** Read `git status`, stage files by name, and write messages in the style of `git log`. One logical change per commit.
6. **Push** with a plain `git push`. A rejected push means sync again.
7. **Pull request,** when the repo uses them: what changed, why, how it was tested, and a link to any ADR.

Merging, tagging, publishing and deploying each wait for the user's go-ahead.

## Done when

The commit hash or pull request URL is reported together with the result of the last test run.
