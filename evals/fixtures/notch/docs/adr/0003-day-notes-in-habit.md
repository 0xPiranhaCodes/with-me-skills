# 0003. Day notes stored as an optional notes map on each habit
Status: accepted
## Context
Users want a short note on a day (e.g. why it was skipped). ADR 0002 keeps misses unstored and derived.
## Decision
Each habit may carry `notes: { "YYYY-MM-DD": text }`, max 140 chars. Absent means no notes, so old saves load unchanged. A note never affects counts and is independent of `done`.
## Alternatives considered
A separate top-level notes list keyed by habit and date: needs cleanup when a habit is deleted. A reason code on missed days: stores misses, which ADR 0002 rejects.
## Consequences
No migration. Deleting a habit deletes its notes. Notes are plain text and must be escaped on render (textContent).
