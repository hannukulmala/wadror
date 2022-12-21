const BREWERIES = {};

const handleResponse = (breweries) => {
  BREWERIES.list = breweries;
  BREWERIES.show();
};

const createTableRow = (brewery) => {
  const tr = document.createElement("tr");
  tr.classList.add("tablerow");
  const breweryname = tr.appendChild(document.createElement("td"));
  breweryname.innerHTML = brewery.name;
  const founded = tr.appendChild(document.createElement("td"));
  founded.innerHTML = brewery.year;
  const beercount = tr.appendChild(document.createElement("td"));
  beercount.innerHTML = brewery.beercount;
  const active = tr.appendChild(document.createElement("td"));
  active.innerHTML = brewery.active;

  return tr;
};

BREWERIES.show = () => {
  document.querySelectorAll(".tablerow").forEach((el) => el.remove());
  const table = document.getElementById("brewerytable");

  BREWERIES.list.forEach((brewery) => {
    const tr = createTableRow(brewery);
    table.appendChild(tr);
  });
};

BREWERIES.sortByName = () => {
  BREWERIES.list.sort((a, b) => {
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
  });
};

BREWERIES.sortByFounded = () => {
  BREWERIES.list.sort((a, b) => {
    return a.year < b.year;
  });
};

BREWERIES.sortByBeerCount = () => {
  BREWERIES.list.sort((a, b) => {
    return a.beercount < b.beercount;
  });
};

BREWERIES.sortByActive = () => {
  BREWERIES.list.sort((a, b) => {
    return b.active - a.active;
  });
};

const breweries = () => {
  if (document.querySelectorAll("#brewerytable").length < 1) return;

  document.getElementById("brewery_name").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortByName();
    BREWERIES.show();
  });

  document.getElementById("brewery_year").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortByFounded();
    BREWERIES.show();
  });

  document.getElementById("brewery_beercount").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortByBeerCount();
    BREWERIES.show();
  });

  document.getElementById("brewery_active").addEventListener("click", (e) => {
    e.preventDefault;
    BREWERIES.sortByActive();
    BREWERIES.show();
  });

  fetch("breweries.json")
    .then((response) => response.json())
    .then(handleResponse);
};

export { breweries };
