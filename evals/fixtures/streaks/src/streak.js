const DAY = 24 * 60 * 60 * 1000;

// dates: ISO day strings like "2026-03-01", one per logged check-in
export function longestStreak(dates) {
  const days = dates.map((d) => Date.parse(d)).sort((a, b) => a - b);
  let best = 0;
  let run = 0;
  let prev = null;
  for (const day of days) {
    run = prev !== null && day - prev === DAY ? run + 1 : 1;
    best = Math.max(best, run);
    prev = day;
  }
  return best;
}
