import test from 'node:test';
import assert from 'node:assert/strict';
import { empty, addHabit, toggle, countLast, dayKey, load, save, setNote } from '../src/store.js';

const mem = (v) => ({ v, getItem() { return this.v ?? null; }, setItem(_, x) { this.v = x; } });

test('addHabit adds a named habit with no done dates', () => {
  const s = addHabit(empty(), 'Read');
  assert.equal(s.habits.length, 1);
  assert.equal(s.habits[0].name, 'Read');
  assert.deepEqual(s.habits[0].done, []);
});

test('addHabit rejects a 6th habit and blank names', () => {
  let s = empty();
  for (const n of 'abcde') s = addHabit(s, n);
  assert.throws(() => addHabit(s, 'f'), /5/);
  assert.throws(() => addHabit(empty(), '  '), /name/);
});

test('toggle marks a date and unmarks it on second call', () => {
  const s = addHabit(empty(), 'Read');
  const on = toggle(s, s.habits[0].id, '2026-11-10');
  assert.deepEqual(on.habits[0].done, ['2026-11-10']);
  assert.deepEqual(toggle(on, s.habits[0].id, '2026-11-10').habits[0].done, []);
});

test('countLast counts done days in the 14-day window ending today', () => {
  const h = { id: 'x', name: 'n', done: ['2026-11-10', '2026-11-08', '2026-10-28', '2026-10-27'] };
  assert.equal(countLast(h, '2026-11-10', 14), 3);
});

test('dayKey uses the local calendar date', () => {
  assert.equal(dayKey(new Date(2026, 10, 10, 23, 30)), '2026-11-10');
});

test('save/load round trips; corrupt storage gives empty state', () => {
  const st = mem();
  const s = addHabit(empty(), 'Read');
  save(st, s);
  assert.deepEqual(load(st), s);
  assert.deepEqual(load(mem('{not json')), empty());
  assert.deepEqual(load(mem()), empty());
});

const withHabit = () => addHabit(empty(), 'Read');

test('setNote stores text for the date and leaves done unchanged', () => {
  const s = withHabit();
  const n = setNote(s, s.habits[0].id, '2026-11-10', ' tired ');
  assert.deepEqual(n.habits[0].notes, { '2026-11-10': 'tired' });
  assert.deepEqual(n.habits[0].done, []);
});

test('setNote with blank text removes the note', () => {
  const s = withHabit();
  const id = s.habits[0].id;
  const n = setNote(setNote(s, id, '2026-11-10', 'tired'), id, '2026-11-10', '  ');
  assert.deepEqual(n.habits[0].notes, {});
});

test('setNote rejects over 140 chars and leaves state unchanged', () => {
  const s = withHabit();
  assert.throws(() => setNote(s, s.habits[0].id, '2026-11-10', 'x'.repeat(141)), /140/);
  assert.equal(s.habits[0].notes, undefined);
  assert.doesNotThrow(() => setNote(s, s.habits[0].id, '2026-11-10', 'x'.repeat(140)));
});

test('toggle keeps the note on the same date', () => {
  const s = withHabit();
  const id = s.habits[0].id;
  const n = toggle(setNote(s, id, '2026-11-10', 'tired'), id, '2026-11-10');
  assert.equal(n.habits[0].notes['2026-11-10'], 'tired');
});

test('notes survive save/load; habits without notes load unchanged', () => {
  const st = mem();
  const s = withHabit();
  save(st, setNote(s, s.habits[0].id, '2026-11-10', 'tired'));
  assert.equal(load(st).habits[0].notes['2026-11-10'], 'tired');
  save(st, s);
  assert.deepEqual(load(st), s);
});

test('a stored note does not change the 14-day count', () => {
  const s = withHabit();
  const n = setNote(setNote(s, s.habits[0].id, '2026-10-20', 'away'), s.habits[0].id, '2026-11-09', 'sick');
  assert.equal(Object.keys(n.habits[0].notes).length, 2);
  assert.equal(countLast(n.habits[0], '2026-11-10', 14), 0);
});
