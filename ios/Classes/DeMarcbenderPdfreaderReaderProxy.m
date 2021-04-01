/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2015 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "DeMarcbenderPdfreaderReaderProxy.h"
#import "DeMarcbenderPdfreaderReader.h"
#import "TiUtils.h"
#import <PDFKit/PDFKit.h>

@implementation DeMarcbenderPdfreaderReaderProxy

- (DeMarcbenderPdfreaderReader *)readerView {
  return (DeMarcbenderPdfreaderReader *)self.view;
}
#pragma mark Public APIs

- (void)search:(id)value {

    [[self readerView] search:[TiUtils stringValue:[value objectAtIndex:0]]];
}

@end
