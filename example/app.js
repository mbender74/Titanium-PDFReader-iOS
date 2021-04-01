// This is a test harness for your module
// You should do something interesting in this harness
// to test out the module and to provide instructions
// to users on how to use it by example.


// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});



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





win.add(pdfView);

// searchFuntion - stringvalue
pdfView.search("searchQueryString");

win.open();


