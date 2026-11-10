# Slices
- [x] 1. Tracer: add a habit, tap to mark today, 14-dot strip and count, saved in localStorage; test runner and run command
- [ ] 2. Rename, delete, 5-habit cap polish, JSON export
- [ ] 3. PWA: manifest, service worker, offline
- [ ] 4. Visual pass and accessibility check

## Slice 1 acceptance criteria
- given no habits, when addHabit("Read"), then one habit with that name and no done dates exists
- given 5 habits, when addHabit, then it throws and state is unchanged
- given a blank name, when addHabit, then it throws
- given a habit, when toggle on 2026-11-10, then that date is done; toggling again clears it
- given done on 11-10, 11-08 and 10-20, when count last 14 days as of 11-10, then 2 (window 10-28..11-10)
- given a saved state, when load from storage, then the same state returns; corrupt or empty storage gives empty state
- given a local Date at 23:30, when todayKey, then the local calendar date, not UTC

## Slice 5: day notes
- [x] 5. Day notes: setNote in store, tappable dots with inline field, marker, styles

### Slice 5 acceptance criteria
- given a habit, when setNote on 2026-11-10 with "tired", then notes holds that text and done is unchanged
- given a note, when setNote with blank text, then the note is removed
- given a note over 140 chars, when setNote, then it throws and state is unchanged
- given a note, when toggle the same date, then the note stays
- given a saved state with notes, when save then load, then the same state returns; a habit without notes loads unchanged
- given a note on 10-20 (outside the window), when countLast as of 11-10, then the count ignores it
