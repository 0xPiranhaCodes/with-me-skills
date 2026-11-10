# 0001. Vanilla JS static PWA with localStorage, no backend
Status: accepted
## Context
Solo project, zero budget, no signup wanted, must work offline and on phones.
## Decision
Plain HTML/CSS/ES modules, a service worker for offline, data in localStorage, Node built-in test runner for logic.
## Alternatives considered
React + Vite with a small backend/DB: more moving parts, needs hosting and accounts.
## Consequences
No sync across devices; data lost if browser storage is cleared (mitigated by JSON export). Zero build, zero hosting cost.
