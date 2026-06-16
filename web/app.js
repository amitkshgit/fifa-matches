const fixtures = [
  {
    date: "2026-06-16",
    homeTeam: "France",
    awayTeam: "Senegal",
    group: "Group I",
    venue: "New York New Jersey Stadium, East Rutherford, NJ"
  },
  {
    date: "2026-06-16",
    homeTeam: "Iraq",
    awayTeam: "Norway",
    group: "Group I",
    venue: "Boston Stadium, Foxborough, MA"
  },
  {
    date: "2026-06-16",
    homeTeam: "Argentina",
    awayTeam: "Algeria",
    group: "Group J",
    venue: "Kansas City Stadium, Kansas City, MO"
  },
  {
    date: "2026-06-16",
    homeTeam: "Austria",
    awayTeam: "Jordan",
    group: "Group J",
    venue: "San Francisco Bay Area Stadium, Santa Clara, CA"
  }
];

const dateInput = document.querySelector("#match-date");
const selectedDate = document.querySelector("#selected-date");
const matchCount = document.querySelector("#match-count");
const groupCount = document.querySelector("#group-count");
const matchList = document.querySelector("#match-list");
const template = document.querySelector("#match-card-template");

document.querySelector("#previous-day").addEventListener("click", () => shiftDate(-1));
document.querySelector("#next-day").addEventListener("click", () => shiftDate(1));
dateInput.addEventListener("change", render);

if ("serviceWorker" in navigator) {
  window.addEventListener("load", () => {
    navigator.serviceWorker.register("service-worker.js");
  });
}

render();

function render() {
  const date = dateInput.value;
  const matches = fixtures.filter((match) => match.date === date);
  const groups = new Set(matches.map((match) => match.group));

  selectedDate.textContent = formatDate(date);
  matchCount.textContent = matches.length;
  groupCount.textContent = groups.size;
  matchList.replaceChildren();

  if (matches.length === 0) {
    matchList.append(emptyState());
    return;
  }

  for (const match of matches) {
    const card = template.content.cloneNode(true);
    card.querySelector(".home").textContent = match.homeTeam;
    card.querySelector(".away").textContent = match.awayTeam;
    card.querySelector(".group").textContent = match.group;
    card.querySelector(".venue").textContent = match.venue;
    matchList.append(card);
  }
}

function shiftDate(days) {
  const nextDate = new Date(`${dateInput.value}T12:00:00`);
  nextDate.setDate(nextDate.getDate() + days);
  dateInput.value = nextDate.toISOString().slice(0, 10);
  render();
}

function formatDate(dateValue) {
  return new Intl.DateTimeFormat("en-US", {
    weekday: "long",
    month: "long",
    day: "numeric",
    year: "numeric"
  }).format(new Date(`${dateValue}T12:00:00`));
}

function emptyState() {
  const wrapper = document.createElement("article");
  wrapper.className = "empty-state";

  const title = document.createElement("h2");
  title.textContent = "No fixtures saved for this date.";

  const body = document.createElement("p");
  body.textContent = "This starter PWA includes the June 16, 2026 FIFA World Cup fixtures. Add more matches in app.js.";

  wrapper.append(title, body);
  return wrapper;
}
