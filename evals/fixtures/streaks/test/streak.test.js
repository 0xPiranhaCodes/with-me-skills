import { test } from "node:test";
import assert from "node:assert/strict";
import { longestStreak } from "../src/streak.js";

test("counts consecutive days", () => {
  assert.equal(longestStreak(["2026-03-01", "2026-03-02", "2026-03-03"]), 3);
});

test("a gap starts a new streak", () => {
  assert.equal(longestStreak(["2026-03-01", "2026-03-02", "2026-03-05"]), 2);
});

test("no check-ins is zero", () => {
  assert.equal(longestStreak([]), 0);
});
