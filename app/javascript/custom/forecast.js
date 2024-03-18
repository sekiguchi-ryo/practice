const area_url = 'https://www.jma.go.jp/bosai/common/const/area.json';
const overview_url = 'https://www.jma.go.jp/bosai/forecast/data/overview_forecast/350000.json';

document.addEventListener("turbo:load", function() {
  // 山口県だけ取得
  const overview = fetchJSON(overview_url);
  const po = document.getElementById("publishingOffice");
  const rd = document.getElementById("reportDatetime");
  const ta = document.getElementById("targetArea");
  const tt = document.getElementById("text");
  overview.then(response => {
    po.textContent = response.publishingOffice;
    rd.textContent = response.reportDatetime;
    ta.textContent = response.targetArea;
    tt.textContent = response.text;
  }).catch(() => {
    const failedMessage = "取得できませんでした";
    po.textContent = failedMessage;
    rd.textContent = failedMessage;
    ta.textContent = failedMessage;
    tt.textContent = failedMessage;
  });
  // resourcesの数だけ取得
  const tableElem = document.getElementById("forecast_table");
  const tbodyElem = tableElem.createTBody();
  fetchAllResources(resources).then((results) => {
    for(const result of results) {
      const trElem = tbodyElem.insertRow();
      const poElem = trElem.insertCell();
      const rdElem = trElem.insertCell();
      const taElem = trElem.insertCell();
      const ttElem = trElem.insertCell();
      poElem.classList.add("border");
      rdElem.classList.add("border");
      taElem.classList.add("border");
      ttElem.classList.add("border");
      poElem.appendChild(document.createTextNode(result.publishingOffice));
      rdElem.appendChild(document.createTextNode(result.reportDatetime));
      taElem.appendChild(document.createTextNode(result.targetArea));
      ttElem.appendChild(document.createTextNode(result.text));
    }
  }).catch(() => {
    const trElem = tbodyElem.insertRow();
    const tdElem = trElem.insertCell();
    tdElem.colSpan = "4";
    tdElem.appendChild(document.createTextNode("取得できませんでした"));
  });
});

async function fetchJSON(url) {
  const response = await fetch(url);
  return await response.json();
}

const resources = ["350000", "020000", "130000"];

async function fetchAllResources(resources) {
  const promises = resources.map((resource) => {
    const target_url = `https://www.jma.go.jp/bosai/forecast/data/overview_forecast/${resource}.json`
    return fetchJSON(target_url);
  });

  const responses = await Promise.all(promises);

  return responses.map((response) => {
    return response;
  });
}