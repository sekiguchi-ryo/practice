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
import "editorjs-text-color-plugin"
if(document.getElementById("editorjs") != null) {
  var content = null;
  var isReadOnly = false;
  var isAutofocus = true;
  const elem_content = document.getElementById('content');
  if(elem_content != null) {
    content = elem_content.value;
    isReadOnly = true;
    isAutofocus = false;
  }
    
  const editor = new EditorJS({
    holder: 'editorjs',
    tools: {
      header: {
        class: Header,
        inlineToolbar: true
      },
      // linkTool: {
      //   class: LinkTool,
      //   config: {
      //     endpoint: 'http://localhost:3000', // Your backend endpoint for url data fetching,
      //   }
      // },
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
      Color: {
        class: window.ColorPlugin, // if load from CDN, please try: window.ColorPlugin
        config: {
           colorCollections: ['#EC7878','#9C27B0','#673AB7','#3F51B5','#0070FF','#03A9F4','#00BCD4','#4CAF50','#8BC34A','#CDDC39', '#FFF'],
           defaultColor: '#FF1300',
           type: 'text', 
           customPicker: true // add a button to allow selecting any colour  
        }     
      },
      Marker: {
        class: window.ColorPlugin, // if load from CDN, please try: window.ColorPlugin
        config: {
           defaultColor: '#FFBF00',
           type: 'marker',
           icon: `<svg fill="#000000" height="200px" width="200px" version="1.1" id="Icons" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 32 32" xml:space="preserve"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <g> <path d="M17.6,6L6.9,16.7c-0.2,0.2-0.3,0.4-0.3,0.6L6,23.9c0,0.3,0.1,0.6,0.3,0.8C6.5,24.9,6.7,25,7,25c0,0,0.1,0,0.1,0l6.6-0.6 c0.2,0,0.5-0.1,0.6-0.3L25,13.4L17.6,6z"></path> <path d="M26.4,12l1.4-1.4c1.2-1.2,1.1-3.1-0.1-4.3l-3-3c-0.6-0.6-1.3-0.9-2.2-0.9c-0.8,0-1.6,0.3-2.2,0.9L19,4.6L26.4,12z"></path> </g> <g> <path d="M28,29H4c-0.6,0-1-0.4-1-1s0.4-1,1-1h24c0.6,0,1,0.4,1,1S28.6,29,28,29z"></path> </g> </g></svg>`
          }       
      },
    },
    // defaultBlock: 'header',
    // onReady: () => {
    //   console.log('Editor.js is ready to work!')
    // },
    // onChange: (api, event) => {
    //   console.log('Now I know that Editor\'s content changed!', event)
    // },
    // placeholder: 'Let`s write an awesome story!',
    // logLevel: 'VERBOSE',
    data: JSON.parse(content),
    autofocus: isAutofocus,
    readOnly: isReadOnly
  });
    
  const save = document.getElementById('save');
  if(save != null) {
    save.addEventListener('click', () => {
      editor.save().then((outputData) => {
          // console.log('Article data: ', outputData)
          document.getElementById('editor_content').value = JSON.stringify(outputData);
          // document.getElementById('output').innerHTML = JSON.stringify(outputData, null, 4);
      }).catch((error) => {
          console.log('Saving fialed: ', error)
      });
    });
  }
}