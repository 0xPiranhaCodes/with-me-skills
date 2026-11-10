# Brief: Notch
## Problem
Habit trackers punish missed days (streaks, red marks, nagging), so people who dislike them quit.
## User
The author first: someone who has tried trackers and abandoned them.
## Scope (v1)
Up to 5 habits; tap to mark today done; neutral empty dot for missed days; "X of last 14 days" count; rename/delete habit; optional 140-char note on any of the 14 days; JSON export; offline PWA.
## Non-goals
Streaks, points, social, reminders/push, accounts, sync, analytics dashboards, monetization.
## Core flow
Open page -> see today's habits -> tap to mark done (or ignore) -> missed days stay neutral -> see plain 14-day count.
## Decisions
- First user -> the author
- v1 success -> still used after 30 days; logging takes under 5 seconds
- Out of v1 -> streaks, points, social, reminders, accounts, sync, dashboards
- Distribution -> open source, free
- Surface -> static mobile-friendly web page, installable PWA
- Data -> browser localStorage only, JSON export
- Habit cap -> 5
- Name -> Notch (user override of "Whenever"); pitch: "A habit tracker with no streaks, no guilt and no nagging."
- Voice -> plain, dry, light humour, no cheerleading
- Visual -> Paper #F6F1E7, Ink #2B2A28, Clay #C8643C (done), Dust #D9D1C2 (empty), Moss #6B7F5A (accent); serif display, system sans body, monospace counts; layout: one calm column of habit rows with a 14-dot strip each
- Tests -> never lose data on reload; never mark the wrong date; latest Chrome/Safari/Firefox; Node built-in test runner, plain ES modules, no build step
- Day notes -> any of the 14 days, done or not; tap a dot to open an inline field; max 140 chars; a Moss underline marks a day with a note
## Assumptions
- Notes live per habit and date in the same localStorage state; old saved data loads unchanged (ADR 0003)
- Nothing prompts for a note; blank note removes it; notes are in the JSON export; deleting a habit deletes its notes
- Note copy is plain and dry: placeholder "Why? (optional)" (change it by saying so)
- Accessibility basics: visible focus, readable contrast, phone width (change it by saying so)
- English only (change it by saying so)
- Dates use device local time (change it by saying so)
- Habits can be renamed or deleted (change it by saying so)
