/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2015 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "DeMarcbenderPdfreaderReader.h"
#import <PDFKit/PDFKit.h>
#import <UIKit/UIKit.h>

@implementation DeMarcbenderPdfreaderReader
NSDate *lastHideTime;
NSString *labeltemplate;

-(void)initializeState
{
    [super initializeState];
    
    if (self)
    {
        NSString *filePath = [TiUtils stringValue:[self.proxy valueForKey:@"pdf"]];
        self.searchResultArray = [[NSMutableArray alloc] init];
       labeltemplate = [TiUtils stringValue:[self.proxy valueForKey:@"labeltemplate"]];

        if(!labeltemplate){
            labeltemplate = @"Page %@ of %lu";
        }
        

        int width = [TiUtils intValue:[self.proxy valueForKey:@"width"]];
        int height = [TiUtils intValue:[self.proxy valueForKey:@"height"]];
        
//        NSLog(@"[INFO] width  %i", width);
//        NSLog(@"[INFO] height  %i", height);
//
//        NSLog(@"[INFO] %@ filePath",filePath);

        self.resultCount = 0;
        
        if (@available(iOS 11.0, *)) {
            
            NSDictionary *dictionary = @{
                   @"interPageSpacing" : @50
            };
            CGRect currentFrame = self.frame;
//            int frameHeight = currentFrame.size.height;
//            int frameWidth = currentFrame.size.width;
            int frameHeight = height;
            int frameWidth = width;
//            readerView = [[PDFView alloc] initWithFrame: self.bounds];
//            NSLog(@"[INFO] currentFrame  %i", frameHeight);
//            NSLog(@"[INFO] currentFrame  %i", frameWidth);

 //           readerView = [[PDFView alloc] initWithFrame:[self frame]];

            readerView = [[PDFView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
            

            UIEdgeInsets pageInsets = UIEdgeInsetsMake(0, 0, 200, 0);
            


            
           readerView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
            

            readerView.translatesAutoresizingMaskIntoConstraints = false;
            [readerView usePageViewController:YES withViewOptions:nil];



            readerView.displayDirection = kPDFDisplayDirectionHorizontal;
            readerView.displayMode = kPDFDisplaySinglePage;
          //  [readerView zoomIn:self];
//            [readerView setDisplaysPageBreaks:YES];

            
            readerView.backgroundColor=[UIColor clearColor];
//            [readerView zoomIn:self];
            readerView.document = [[PDFDocument alloc]initWithURL:[NSURL fileURLWithPath:filePath]];
            self.pdfDocument = readerView.document;
//            readerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
            readerView.document.delegate = self;
            readerView.maxScaleFactor = 4.0;
//            readerView.minScaleFactor = 0.6;
            readerView.minScaleFactor = readerView.scaleFactorForSizeToFit;
            readerView.autoScales = true;
            [readerView setDisplaysPageBreaks:YES];
            [readerView setDisplayBox:kPDFDisplayBoxTrimBox];
            [readerView setLayoutMargins:pageInsets];

            int thumbnailsize = 40;

            //            thumbnailView = [[PDFThumbnailView alloc] initWithFrame:CGRectMake(0, 0, 500, 500)];
            

            
            int bottomFrame = frameHeight - 200;
            int thumbFrameWidth = frameWidth - 40;
            int labelLeft = frameWidth / 2;
            int labelCenterY = bottomFrame - 50;
            int leading = 1;

            
            bottomContainer = [[UIView alloc] initWithFrame:CGRectMake(0, bottomFrame, frameWidth, 150)];
            bottomContainer.autoresizesSubviews = YES;
            
            thumbnailView = [[PDFThumbnailView alloc] initWithFrame:CGRectMake(0, 80, frameWidth, 80)];
            thumbnailView.translatesAutoresizingMaskIntoConstraints = false;

          //  thumbnailView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        //    thumbnailView.autoresizesSubviews = YES;
            
//            thumbnailView.heightAnchor.constraint(equalToConstant: CGFloat(thumbnailSize)),
//            thumbnailView.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor),
//            thumbnailView.trailingAnchor.constraint(equalTo: bottomContainer.trailingAnchor),
//            thumbnailView.bottomAnchor.constraint(equalTo: bottomContainer.bottomAnchor)
            
            
//            NSLayoutConstraint.activate([
//                pdfThumbnailView.heightAnchor.constraint(equalToConstant: CGFloat(thumbnailSize)),
//                pdfThumbnailView.widthAnchor.constraint(equalToConstant: CGFloat(pdfDocument.pageCount*thumbnailSize))
//            ])
//
//            [thumbnailView.leadingAnchor constraintEqualToAnchor:bottomContainer.leadingAnchor].active = YES;
//            [thumbnailView.trailingAnchor constraintEqualToAnchor:bottomContainer.trailingAnchor].active = YES;
//            [thumbnailView.bottomAnchor constraintEqualToAnchor:bottomContainer.bottomAnchor constant:10].active = YES;
//
            CGFloat scrollwidth = (frameWidth-10);
            
//            [thumbnailView.heightAnchor constraintEqualToConstant:60].active = YES;
//
//            [thumbnailView.widthAnchor constraintEqualToConstant:scrollwidth].active = YES;

          //  [thumbnailView.leadingAnchor constraintEqualToAnchor:bottomContainer.leadingAnchor].active = YES;

            
            
            [thumbnailView setLayoutMode:PDFThumbnailLayoutModeHorizontal];
            
//            thumbnailView.thumbnailSize = CGSizeMake(60, 40);
            [thumbnailView setPDFView:readerView];

            [thumbnailView setThumbnailSize:CGSizeMake(thumbnailsize, 60)];
            thumbnailView.backgroundColor = [UIColor clearColor];

        
            
            
            
            
            pageNumberContainer = [[UIView alloc] initWithFrame:CGRectMake(labelLeft - (180/2), 20, 180, 40)];
          //  pageNumberContainer.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
           // pageNumberContainer.translatesAutoresizingMaskIntoConstraints = false;
           // [pageNumberContainer setCenter:CGPointMake(labelLeft, labelCenterY)];

            pageNumberContainer.autoresizesSubviews = NO;

            
            
            pageNumberLabel = [[UILabel alloc] init];
            
            CGRect currentLabelFrame = pageNumberLabel.frame;
            currentLabelFrame.size = CGSizeMake(180, 40);
            pageNumberLabel.frame = currentLabelFrame;
            pageNumberLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
       
            pageNumberLabel.translatesAutoresizingMaskIntoConstraints = false;

            
            CGFloat fontSize = (([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) ? 19.0f : 16.0f);

            pageNumberLabel.autoresizesSubviews = NO;
            pageNumberLabel.userInteractionEnabled = NO;
            pageNumberLabel.contentMode = UIViewContentModeRedraw;
            pageNumberLabel.textAlignment = NSTextAlignmentCenter;
            pageNumberLabel.font = [UIFont systemFontOfSize:fontSize];
            pageNumberLabel.textColor = [UIColor whiteColor];
            pageNumberLabel.backgroundColor = [UIColor colorWithWhite:0.24f alpha:0.7f];
            pageNumberLabel.text = [NSString stringWithFormat:labeltemplate, readerView.currentPage.label, (unsigned long)readerView.document.pageCount];
          //  [pageNumberLabel sizeToFit];
           // [pageNumberLabel setCenter:CGPointMake(labelLeft, labelCenterY)];
            
//            CGPoint currentLabelCenter = pageNumberLabel.center;
//            currentLabelCenter.y = labelCenterY;
//            pageNumberLabel.center = currentLabelCenter;
            
            [self addSubview:readerView];
            [self addSubview:bottomContainer];
            [bottomContainer addSubview:thumbnailView];
            [bottomContainer addSubview:pageNumberContainer];
//
//            [self addSubview:thumbnailView];
//            [self addSubview:pageNumberContainer];
            [pageNumberContainer addSubview:pageNumberLabel];
            bottomContainer.hidden = true;
            
//            UITapGestureRecognizer *singleTapOne = [[UITapGestureRecognizer alloc] initWithTarget:readerView action:@selector(handleSingleTap:)];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleBottomView)];
            [readerView addGestureRecognizer:tap];

            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PDFViewPageChangedNotification:) name:PDFViewPageChangedNotification object:readerView];

            
        } else {
            // Fallback on earlier versions
        }

        
        

        
    }
}

-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    if (readerView != nil) {
        [TiUtils setView:readerView positionRect:bounds];
   }
}


#pragma mark - Toggle Bottom View
-(void)toggleBottomView {
    //NSLog(@"[INFO] %@ toggleBottomView");

    [UIView transitionWithView:bottomContainer
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
        bottomContainer.hidden = !bottomContainer.hidden;
                    }
                    completion:NULL];
//    [PDFThumbnailView transitionWithView:thumbnailView
//                      duration:0.3
//                       options:UIViewAnimationOptionTransitionCrossDissolve
//                    animations:^{
//                        thumbnailView.hidden = !thumbnailView.hidden;
//                    }
//                    completion:NULL];
}



#pragma mark - PDFSelection Delegate

-(void)documentDidBeginDocumentFind:(NSNotification *)notification{
    self.resultCount = 0;
if (!self.searchResultArray){
//    NSLog(@"[INFO] %@ documentDidBeginDocumentFind");

    self.searchResultArray = [[NSMutableArray alloc]init];
}

}
-(void)documentDidEndDocumentFind:(NSNotification *)notification
{
//    NSLog(@"[INFO] documentDidEndDocumentFind  %i", self.resultCount);
    [readerView setHighlightedSelections:[self.searchResultArray copy]];

    NSMutableDictionary *event = [[NSMutableDictionary alloc] init];

    [event setValue:[[NSNumber alloc] initWithInt:self.resultCount] forKey:@"results"];

    if ([self.proxy _hasListeners:@"searchresult"]) {
        [self.proxy fireEvent:@"searchresult" withObject:event];
    }
   // [self.searchResultArray removeAllObjects];
}


-(void)didMatchString:(PDFSelection *)instance{
//    NSLog(@"[INFO] %@ didMatchString");
    self.resultCount = self.resultCount + 1;
    [self.searchResultArray addObject:instance];
}

#pragma mark - PDFViewPageChangedNotification
-(void)PDFViewPageChangedNotification:(NSNotification*)notification{

    pageNumberLabel.text = [NSString stringWithFormat:labeltemplate, readerView.currentPage.label, (unsigned long)readerView.document.pageCount];

}





//if ([self.proxy _hasListeners:@"load"])
//                               [self.proxy fireEvent:@"load" withObject:event];
//                           }
#pragma mark Public APIs

- (void)search:(NSString*)searchText
{
//    NSLog(@"[INFO] %@ search",searchText);


    [readerView.document beginFindString:searchText withOptions:NSCaseInsensitiveSearch];
}
-(void)showHideBottomView {
    //NSLog(@"[INFO] %@ toggleBottomView");

    [UIView transitionWithView:pageNumberContainer
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        pageNumberContainer.hidden = !pageNumberContainer.hidden;
                    }
                    completion:NULL];
    [PDFThumbnailView transitionWithView:thumbnailView
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        thumbnailView.hidden = !thumbnailView.hidden;
                    }
                    completion:NULL];
}
@end
