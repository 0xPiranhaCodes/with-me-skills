import { load, save, addHabit, toggle, setNote, MAX_NOTE, dayKey, lastDays, countLast } from './store.js';

let state = load(localStorage);
let open = null; // {id, key} of the day whose note field is showing
const $ = (id) => document.getElementById(id);
const commit = (s) => { state = s; save(localStorage, s); render(); };

function render() {
  const today = dayKey();
  const days = lastDays(today, 14);
  $('habits').replaceChildren(...state.habits.map((h) => {
    const li = document.createElement('li');
    const done = h.done.includes(today);
    li.innerHTML = `<div class="row"><span></span><button aria-pressed="${done}">${done ? 'Done today' : 'Mark today'}</button></div>
      <div class="dots">${days.map((k) => `<button type="button" data-k="${k}" class="${h.done.includes(k) ? 'on' : ''}${h.notes?.[k] ? ' noted' : ''}" aria-label="${k}, ${h.done.includes(k) ? 'done' : 'not done'}${h.notes?.[k] ? ', has note' : ''}"></button>`).join('')}</div>
      <span class="count">${countLast(h, today, 14)} of last 14 days</span>`;
    li.querySelector('span').textContent = h.name;
    li.querySelector('button').onclick = () => commit(toggle(state, h.id, dayKey()));
    li.querySelectorAll('.dots button').forEach((b) => {
      b.onclick = () => { open = open?.id === h.id && open.key === b.dataset.k ? null : { id: h.id, key: b.dataset.k }; render(); };
    });
    if (open?.id === h.id) {
      const f = document.createElement('form');
      f.className = 'note';
      f.innerHTML = `<label class="sr" for="n-${h.id}"></label><input id="n-${h.id}" maxlength="${MAX_NOTE}" placeholder="Why? (optional)" autocomplete="off"><button>Save</button>`;
      f.querySelector('label').textContent = `Note for ${open.key}`;
      f.querySelector('input').value = h.notes?.[open.key] ?? '';
      f.onsubmit = (e) => { e.preventDefault(); const k = open.key; open = null; commit(setNote(state, h.id, k, f.querySelector('input').value)); };
      li.append(f);
    }
    return li;
  }));
}

$('add').onsubmit = (e) => {
  e.preventDefault();
  try { commit(addHabit(state, $('name').value)); $('name').value = ''; $('msg').textContent = ''; }
  catch (err) { $('msg').textContent = err.message; }
};
render();
