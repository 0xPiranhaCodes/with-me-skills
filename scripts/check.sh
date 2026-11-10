#!/bin/sh
# Validates the pack and prints the load-cost table for the README.
set -eu
cd "$(dirname "$0")/.."

fail=0
err() { echo "FAIL: $*"; fail=1; }
lines() { wc -l < "$1" | tr -d ' '; }
# shortcut: ~4 characters per token, swap in a real tokenizer if the README numbers are ever disputed
tokens() { echo $(( $(cat "$@" | wc -c) / 4 )); }

for f in core/*.md; do
  [ "$(lines "$f")" -le 80 ] || err "$f is over 80 lines"
done

for dir in skills/*/; do
  name=$(basename "$dir")
  s=${dir}SKILL.md
  [ "$(sed -n 1p "$s")" = "---" ] || err "$s has no frontmatter"
  [ "$(sed -n 's/^name: //p' "$s")" = "$name" ] || err "$s: name must be $name"
  desc=$(sed -n 's/^description: //p' "$s")
  [ -n "$desc" ] || err "$s has no description"
  [ "${#desc}" -le 300 ] || err "$s: description is ${#desc} characters, limit 300"
  [ "$(lines "$s")" -le 60 ] || err "$s is over 60 lines"

  for ref in $(grep -o 'references/[a-z-]*\.md' "$s" | sort -u); do
    [ -f "$dir$ref" ] || err "$s points at missing $ref"
  done
  for r in "$dir"references/*.md; do
    cmp -s "$r" "core/$(basename "$r")" || err "$r differs from core/, run scripts/sync.sh"
  done
  # a reference that names a sibling core file needs that file installed beside it
  for c in core/*.md; do
    b=$(basename "$c")
    if grep -qF "\`$b\`" "$dir"references/*.md && [ ! -f "${dir}references/$b" ]; then
      err "$name references mention $b but it is not synced into the skill"
    fi
  done
done

[ "$fail" -eq 0 ] || exit 1

b=skills/build-with-me
r=$b/references
echo "| Run | Approx. tokens loaded |"
echo "|---|---|"
echo "| Three descriptions, always in context | $(( $(sed -n 's/^description: //p' skills/*/SKILL.md | wc -c) / 4 )) |"
echo "| debug-with-me, a bug | $(tokens skills/debug-with-me/SKILL.md $(ls skills/debug-with-me/references/*.md | grep -v ship)) |"
echo "| build-with-me, tier S change | $(tokens $b/SKILL.md $r/sizing.md $r/build-loop.md $r/persona-sdet.md $r/persona-engineer.md $r/persona-reviewer.md) |"
echo "| build-with-me, tier M with 3 personas | $(tokens $b/SKILL.md $r/sizing.md $r/research.md $r/panel.md $r/persona-cto.md $r/persona-designer.md $r/persona-sdet.md $r/docs.md $r/build-loop.md $r/persona-engineer.md $r/persona-reviewer.md) |"
echo "| build-with-me, tier L, everything | $(tokens $b/SKILL.md $(ls $r/*.md | grep -v -e debug-loop -e ship)) |"
echo "| Shipping, added only when you ask | $(tokens $r/ship.md) |"
echo "| design-with-me, tier L | $(tokens skills/design-with-me/SKILL.md skills/design-with-me/references/*.md) |"
