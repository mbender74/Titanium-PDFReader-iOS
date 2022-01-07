<<<<<<< HEAD
# PDFReader for iOS (based on Apple PDFKit)
## PDF-Reader-View module for Appcelerator Titanium
=======
# Titanium PDFReader Module
>>>>>>> main

<img src="./demo.gif" width="293" height="634" alt="Example" />



<<<<<<< HEAD
Simple iOS View module for Appcelerator Titanium that can display PDF files with thumnail slider and serach function

### Usage

```xml
<modules>
  <module platform="ios">de.marcbender.pdfreader</module>
</modules>
```

```xml
```
or
```javascript
=======
## Example
```js

>>>>>>> main
var win = Ti.UI.createWindow({
	backgroundColor: '#fff'
});


var  pdfReaderModule = require('de.marcbender.pdfreader');

var pdfView = pdfReaderModule.createReader({
<<<<<<< HEAD
    height:Ti.UI.FiLL,
	width:Ti.UI.FiLL,
=======
  height: Ti.Platform.displayCaps.platformHeight - 90,
	width: Ti.Platform.displayCaps.platformWidth,
>>>>>>> main
	top: 0,
	left:0,
	right:0,
	bottom:0,
	labeltemplate:'Page'+' %@ '+'from'+' %lu',
<<<<<<< HEAD
=======
	clipMode: Titanium.UI.iOS.CLIP_MODE_DISABLED,
>>>>>>> main
	backgroundColor:'white',
	pdf:Ti.Filesystem.getFile( Ti.Filesystem.resourcesDirectory , "test.pdf" ).resolve(),
});

pdfView.addEventListener('searchresult', function (e) {
<<<<<<< HEAD
		Ti.API.info("RESULTS: " +e.count);	
=======
		Ti.API.info("RESULTS: " + JSON.stringify(e));	
>>>>>>> main
});

win.add(pdfView);

<<<<<<< HEAD
// searchFuntion - stringvalue
pdfView.search("searchQueryString");

```

### API

<b>Properties:</b>
* pdf:pdfFilePath
* labeltemplate:'Page'+' %@ of'+' %lu'
    change only "Page" and "of" to your needed language....


=======
>>>>>>> main
```
