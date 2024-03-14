import "editorjs-html"
if(document.getElementById("content") != null) {
  const content = document.getElementById('content').value;
  const edjsParser = edjsHTML({
    image: simpleImageParser,
    checklist: checkListParser,
    list: listParser,
    raw: rawParser
  });
  let html = edjsParser.parse(JSON.parse(content)).reduce((x, y) => `${x}${y}`);
  document.getElementById("render-html").innerHTML = html;
}

function simpleImageParser(block) {
  return `<div><img src="${block.data.url}"></div>`;
}

function checkListParser(block) {
  let html = `<div data-id="${block.id}">`;
  for(let obj in block.data.items) {
    html += `<div>${block.data.items[obj]["text"]}</div>`;
  }
  html += `</div>`;
  return html;
}

function listParser(block) {
  let html = `<div data-id="${block.id}">`;
  html += `<ol>`;
  for(let obj in block.data.items) {
    html += `<li>${block.data.items[obj]}</li>`;
  }
  html += `</ol>`;
  return html;
}

function rawParser(block) {
  return `<div data-id="${block.id}">${block.data.html}</div>`;
}