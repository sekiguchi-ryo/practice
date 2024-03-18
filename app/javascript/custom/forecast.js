const area_url = 'https://www.jma.go.jp/bosai/common/const/area.json';
const overview_root_url = 'https://www.jma.go.jp/bosai/forecast/data/overview_forecast';
const yamaguchi_area_code = "350000";
const resources = ["350000", "020000", "130000", "230000", "270000", "390000", "440000"];
const failedMessage = "取得できませんでした";

document.addEventListener("turbo:load", function() {
  // 山口県だけ取得
  get_yamaguchi_overview();
  // resourcesの数だけ取得
  get_resources_overview();
  // エリアを選択して取得
  get_selected_area_overview();
});

function get_yamaguchi_overview() {
  const overview_url_yamaguchi = `${overview_root_url}/${yamaguchi_area_code}.json`;
  const overview = fetchJSON(overview_url_yamaguchi);
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
    po.textContent = failedMessage;
    rd.textContent = failedMessage;
    ta.textContent = failedMessage;
    tt.textContent = failedMessage;
  });
}

function get_resources_overview() {
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
    tdElem.appendChild(document.createTextNode(failedMessage));
  });
}

function get_selected_area_overview() {
  const selectElem = document.getElementById("forecast_select");
  const area = fetchJSON(area_url);
  area.then(response => {
    const offices = response.offices;
    const keys = Object.keys(offices).sort();
    for (const key in keys) {
      let optionElem = document.createElement("option");
      optionElem.text = offices[keys[key]]["name"];
      optionElem.value = keys[key];
      selectElem.appendChild(optionElem);
    }
  });
  selectElem.addEventListener('change', function() {
    const area_code = selectElem.value;
    const po = document.getElementById("publishingOffice_area");
    const rd = document.getElementById("reportDatetime_area");
    const ta = document.getElementById("targetArea_area");
    const tt = document.getElementById("text_area");
    if(area_code != "000000") {
      const overview_url =  `${overview_root_url}/${area_code}.json`;
      const overview = fetchJSON(overview_url);
      overview.then(response => {
        po.textContent = response.publishingOffice;
        rd.textContent = response.reportDatetime;
        ta.textContent = response.targetArea;
        tt.textContent = response.text;
      }).catch(() => {
        po.textContent = failedMessage;
        rd.textContent = failedMessage;
        ta.textContent = failedMessage;
        tt.textContent = failedMessage;
      });
    } else {
        po.textContent = null;
        rd.textContent = null;
        ta.textContent = null;
        tt.textContent = null;
    }
  });
}

async function fetchJSON(url) {
  const response = await fetch(url);
  return await response.json();
}

async function fetchAllResources(resources) {
  const promises = resources.map((resource) => {
    const target_url = `${overview_root_url}/${resource}.json`
    return fetchJSON(target_url);
  });
  const responses = await Promise.all(promises);
  return responses.map((response) => {
    return response;
  });
}