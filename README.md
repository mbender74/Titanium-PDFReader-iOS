# PDFReader for iOS (based on Apple PDFKit)
## PDF-Reader-View module for Appcelerator Titanium

<img src="./demo.gif" width="293" height="634" alt="Example" />



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
var win = Ti.UI.createWindow({
	backgroundColor: '#fff'
});


var  pdfReaderModule = require('de.marcbender.pdfreader');

var pdfView = pdfReaderModule.createReader({
    height:Ti.UI.FiLL,
	width:Ti.UI.FiLL,
	top: 0,
	left:0,
	right:0,
	bottom:0,
	labeltemplate:'Page'+' %@ '+'from'+' %lu',
	backgroundColor:'white',
	pdf:Ti.Filesystem.getFile( Ti.Filesystem.resourcesDirectory , "test.pdf" ).resolve(),
});

pdfView.addEventListener('searchresult', function (e) {
		Ti.API.info("RESULTS: " +e.count);	
});

win.add(pdfView);

// searchFuntion - stringvalue
pdfView.search("searchQueryString");

```

### API

<b>Properties:</b>
* pdf:pdfFilePath
* labeltemplate:'Page'+' %@ of'+' %lu'
    change only "Page" and "of" to your needed language....


```
