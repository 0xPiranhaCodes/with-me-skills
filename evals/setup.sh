#!/bin/sh
# Prepares a fresh working directory for one golden scenario: fixture + the skills installed.
# usage: sh evals/setup.sh <bug|new-project|resume|feature> <new-directory>
set -eu
here=$(cd "$(dirname "$0")" && pwd)
scenario=${1:?usage: setup.sh <bug|new-project|resume|feature> <new-directory>}
dir=${2:?usage: setup.sh <bug|new-project|resume|feature> <new-directory>}

case $scenario in
  bug) fixture=streaks ;;
  resume | feature) fixture=notch ;;
  new-project) fixture= ;;
  *) echo "unknown scenario: $scenario" >&2; exit 2 ;;
esac

[ ! -e "$dir" ] || { echo "$dir already exists" >&2; exit 2; }
mkdir -p "$dir"
[ -z "$fixture" ] || cp -R "$here/fixtures/$fixture/." "$dir"

cd "$dir"
git init -q
if [ -n "$fixture" ]; then
  git add -A
  git -c user.name=golden -c user.email=golden@example.com commit -qm "fixture: $fixture"
fi

# installed after the commit so the skills never show up in the scenario's diff
for agent_dir in .claude/skills .agents/skills; do
  mkdir -p "$agent_dir"
  cp -R "$here/../skills/." "$agent_dir"
done
echo "ready: $dir"
