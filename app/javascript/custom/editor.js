import "@editorjs/editorjs"
import "@editorjs/header"
import "@editorjs/link"
import "@editorjs/raw"
import "@editorjs/simple-image"
import "@editorjs/image"
import "@editorjs/checklist"
import "@editorjs/list"
import "@editorjs/embed"
import "@editorjs/quote"
document.addEventListener('turbo:load', ()=>{
  if(document.getElementById("editorjs") == null) {
    return;
  }
  const editor = new EditorJS({
      autofocus: true,
      holder: 'editorjs',
      tools: {
        header: Header,
        linkTool: {
          class: LinkTool,
          config: {
            endpoint: 'http://localhost:8008/fetchUrl', // Your backend endpoint for url data fetching,
          }
        },
        raw: RawTool,
        image: SimpleImage,
        image: {
          class: ImageTool,
          config: {
            endpoints: {
              byFile: 'http://localhost:8008/uploadFile', // Your backend file uploader endpoint
              byUrl: 'http://localhost:8008/fetchUrl', // Your endpoint that provides uploading by Url
            }
          }
        },
        checklist: Checklist,
        list: List,
        embed: Embed,
        quote: Quote,
      },
      onReady: () => {
        console.log('Editor.js is ready to work!')
      }
  });
  
  const save = document.getElementById('save');
  save.addEventListener('click', () => {
    editor.save().then((outputData) => {
        console.log('Article data: ', outputData)
    }).catch((error) => {
        console.log('Saving fialed: ', error)
    });
  });
});