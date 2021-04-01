/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2015 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiUIView.h"
#import <PDFKit/PDFKit.h>
#import <UIKit/UIKit.h>
@protocol DeMarcbenderPdfreaderReaderDelegate;

@interface DeMarcbenderPdfreaderReader : TiUIView < PDFDocumentDelegate > {


@private
    PDFView *readerView;
    PDFThumbnailView *thumbnailView;
    UILabel *pageNumberLabel;
    UIView *pageNumberContainer;
    UIView *bottomContainer;
    int thumbnailsize;
}
@property int *resultCount;

@property (strong, nonatomic) PDFDocument *pdfDocument;
@property (strong, nonatomic) NSMutableArray<PDFSelection *> *searchResultArray;

//
//-(void)setPdf_:(id)args;
- (void)search:(NSString*)searchText;
-(void)toggleBottomView;
-(void)showHideBottomView;


@end
