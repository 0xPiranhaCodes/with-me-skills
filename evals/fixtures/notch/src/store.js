export const MAX_HABITS = 5;
const KEY = 'notch';
const pad = (n) => String(n).padStart(2, '0');

export const empty = () => ({ habits: [] });

export const dayKey = (d = new Date()) => `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}`;

export function addHabit(s, name) {
  name = String(name).trim();
  if (!name) throw new Error('name required');
  if (s.habits.length >= MAX_HABITS) throw new Error(`max ${MAX_HABITS} habits`);
  return { habits: [...s.habits, { id: crypto.randomUUID(), name, done: [] }] };
}

export function toggle(s, id, key) {
  return {
    habits: s.habits.map((h) => h.id !== id ? h
      : { ...h, done: h.done.includes(key) ? h.done.filter((k) => k !== key) : [...h.done, key] }),
  };
}

// Last n local dates ending at `today`, oldest first (noon avoids DST edge cases).
export function lastDays(today, n) {
  const [y, m, d] = today.split('-').map(Number);
  return Array.from({ length: n }, (_, i) => dayKey(new Date(y, m - 1, d - (n - 1 - i), 12)));
}

export const countLast = (h, today, n) => lastDays(today, n).filter((k) => h.done.includes(k)).length;

export function load(storage) {
  try {
    const s = JSON.parse(storage.getItem(KEY));
    return Array.isArray(s?.habits) ? s : empty();
  } catch { return empty(); }
}

export const save = (storage, s) => storage.setItem(KEY, JSON.stringify(s));

export const MAX_NOTE = 140;
export function setNote(s, id, key, text) {
  text = String(text).trim();
  if (text.length > MAX_NOTE) throw new Error(`note max ${MAX_NOTE} chars`);
  return {
    habits: s.habits.map((h) => {
      if (h.id !== id) return h;
      const { [key]: _, ...rest } = h.notes ?? {};
      return { ...h, notes: text ? { ...rest, [key]: text } : rest };
    }),
  };
}
