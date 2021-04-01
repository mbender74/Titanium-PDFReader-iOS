# PDFReader for iOS (based on Apple PDFKit)
## PDF-Reader-View module for Appcelerator Titanium




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
var pdfReader = require('de.marcbender.pdfreader');



var pdfView = pdfReader.createReader({
            height: Ti.Platform.displayCaps.platformHeight - 90,
            width: Ti.Platform.displayCaps.platformWidth,
            top: 0,
            left:0,
            right:0,
            bottom:0,
            labeltemplate:'Page'+' %@ of'+' %lu',
            backgroundColor:'grey',
            pdf:Ti.Filesystem.getFile( Ti.Filesystem.applicationDataDirectory , "yourfile.pdf" ).resolve(),
});


// returns result count - matched strings will be highlighted in the pdf pages
pdfView.addEventListener('searchresult', function (e) {
        Ti.API.info("RESULTS: " + JSON.stringify(e));
});

// searchFuntion - stringvalue
pdfView.search("searchQueryString");
```

### API

<b>Properties:</b>
* pdf:pdfFilePath
* labeltemplate:'Page'+' %@ of'+' %lu'
    change only "Page" and "of" to your needed language....


```
