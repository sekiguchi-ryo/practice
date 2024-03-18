const area_url = 'https://www.jma.go.jp/bosai/common/const/area.json';
const overview_url = 'https://www.jma.go.jp/bosai/forecast/data/overview_forecast/350000.json';

document.addEventListener("turbo:load", function() {
  const overview = fetchJSON(overview_url);
  overview.then(response => {
    document.getElementById("publishingOffice").textContent = response.publishingOffice;
    document.getElementById("reportDatetime").textContent = response.reportDatetime;
    document.getElementById("targetArea").textContent = response.targetArea;
    document.getElementById("text").textContent = response.text;
  });
});

async function fetchJSON(url) {
  const response = await fetch(url);
  return await response.json();
}