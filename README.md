# Titanium PDFReader Module

<img src="./demo.gif" width="293" height="634" alt="Example" />



## Example
```js

var win = Ti.UI.createWindow({
	backgroundColor: '#fff'
});


var  pdfReaderModule = require('de.marcbender.pdfreader');

var pdfView = pdfReaderModule.createReader({
  height: Ti.Platform.displayCaps.platformHeight - 90,
	width: Ti.Platform.displayCaps.platformWidth,
	top: 0,
	left:0,
	right:0,
	bottom:0,
	labeltemplate:'Page'+' %@ '+'from'+' %lu',
	clipMode: Titanium.UI.iOS.CLIP_MODE_DISABLED,
	backgroundColor:'white',
	pdf:Ti.Filesystem.getFile( Ti.Filesystem.applicationDataDirectory , "test.pdf" ).resolve(),
});

pdfView.addEventListener('searchresult', function (e) {
		Ti.API.info("RESULTS: " + JSON.stringify(e));	
});

win.add(pdfView);

```
