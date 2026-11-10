# 0002. Store only done-dates; no streak or penalty state
Status: accepted
## Context
The product premise is that a lapse is normal.
## Decision
Data model is habits with a set of done ISO local dates. Progress is derived (count in last 14 days); nothing is stored about misses.
## Alternatives considered
Storing streak counters or missed flags: easier to display, but invites guilt mechanics and corrupt state.
## Consequences
Adding streaks later is a derivation, not a migration; the data format is stable and exportable.
