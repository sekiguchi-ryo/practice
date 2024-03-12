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
  var content = null;
  var readonly = false;
  var autofocus = true;
  const elem_content = document.getElementById('content');
  if(elem_content != null) {
    content = elem_content.value;
    readonly = true;
    autofocus = false;
  }

  const editor = new EditorJS({
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
      // image: {
      //   class: ImageTool,
      //   config: {
      //     endpoints: {
      //       byFile: 'http://localhost:8008/uploadFile', // Your backend file uploader endpoint
      //       byUrl: 'http://localhost:8008/fetchUrl', // Your endpoint that provides uploading by Url
      //     }
      //   }
      // },
      checklist: Checklist,
      list: List,
      embed: Embed,
      quote: Quote,
    },
    onReady: () => {
      console.log('Editor.js is ready to work!')
    },
    onChange: (api, event) => {
      console.log('Now I know that Editor\'s content changed!', event)
    },
    placeholder: 'Let`s write an awesome story!',
    logLevel: 'VERBOSE',
    data: JSON.parse(content),
    autofocus: autofocus,
    readOnly: readonly
  });

  const save = document.getElementById('save');
  if(save != null) {
    save.addEventListener('click', () => {
      editor.save().then((outputData) => {
          console.log('Article data: ', outputData)
          document.getElementById('editor_content').value = JSON.stringify(outputData);
      }).catch((error) => {
          console.log('Saving fialed: ', error)
      });
    });
  }
});