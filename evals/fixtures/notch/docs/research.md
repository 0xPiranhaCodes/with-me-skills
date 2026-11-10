# Research: a habit tracker for people who hate habit trackers

No web search used; rows from prior knowledge, all `unverified`.

| Project | What it is | Stack | Copy | Avoid |
|---|---|---|---|---|
| Loop Habit Tracker (unverified) | Open-source Android tracker with flexible schedules | Kotlin/Java, SQLite | Score that decays gently instead of a brittle streak | Dense charts and settings; feels like a dashboard |
| Habitica (unverified) | RPG-gamified habits and to-dos | Node, Vue, MongoDB | Social stakes, playful tone | Gamification overload, punishing HP loss |
| Streaks (unverified) | Minimal iOS app, 12 habits max | Native iOS | Hard cap on habit count; one-tap check | Streak anxiety; a broken streak resets to 0 |
| Beeminder (unverified) | Goal tracker with money at stake | Rails web app | Commitment device that works | Financial penalty is hostile to quitters |
| Way of Life (unverified) | Colour-coded yes/no journal | Native mobile | Calendar of dots, no judgment text | Paywall, manual logging chore |

**Gap:** Every tracker punishes a missed day; none treats a lapse as normal, with no streaks, no guilt, and near-zero upkeep.

# Research: a short note on a day

No web search used; rows from prior knowledge, all `unverified`.

| Project | What it is | Stack | Copy | Avoid |
|---|---|---|---|---|
| Loop Habit Tracker (unverified) | Open-source Android tracker | Kotlin, SQLite | Note is optional, attached to one habit-day, set from the day's own menu | Notes buried two screens deep |
| Streaks (unverified) | Minimal iOS habit app | Native iOS | Skipping a day is a first-class action | Skip still feeds streak anxiety |
| Way of Life (unverified) | Colour-coded yes/no journal | Native mobile | Tap a day, a comment field appears; notes sit beside the dot | Paywalled; comment prompts nag |

**Gap:** Notes elsewhere explain a failure; here a note can just say why, with no judgement and nothing derived from it.

**Already decided by the repo:** vanilla ES modules, `node --test`, immutable pure functions in `src/store.js` (`toggle` is the nearest feature), UI in `src/ui.js`; data is `{habits:[{id,name,done:[dayKeys]}]}` (ADR 0002).
