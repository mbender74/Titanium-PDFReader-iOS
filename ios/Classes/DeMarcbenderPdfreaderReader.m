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

-(void)initializeState
{
    
    if (self)
    {
        initDone = NO;

        NSString *filePath = [TiUtils stringValue:[self.proxy valueForKey:@"pdf"]];
        searchResultArray = [[NSMutableArray alloc] init];
       labeltemplate = [TiUtils stringValue:[self.proxy valueForKey:@"labeltemplate"]];

        if(!labeltemplate){
            labeltemplate = @"Page %@ of %lu";
        }

        resultCount = 0;
        
       // if (@available(iOS 11.0, *)) {
            
            NSDictionary *dictionary = @{
                   @"interPageSpacing" : @50
            };
            CGRect currentFrame = self.frame;
//            int frameHeight = currentFrame.size.height;
//            int frameWidth = currentFrame.size.width;
           
//            readerView = [[PDFView alloc] initWithFrame: self.bounds];
//            NSLog(@"[INFO] currentFrame  %i", frameHeight);
//            NSLog(@"[INFO] currentFrame  %i", frameWidth);

 //           readerView = [[PDFView alloc] initWithFrame:[self frame]];

            
            
            readerView = [[PDFView alloc] init];

            UIEdgeInsets pageInsets = UIEdgeInsetsMake(0, 0, 100, 0);
            
            
          // readerView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
            
          //  [readerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];

            
            NSDictionary* options = @{ UIPageViewControllerOptionInterPageSpacingKey : [NSNumber numberWithFloat:10.0f]};

            readerView.translatesAutoresizingMaskIntoConstraints = NO;
            [readerView usePageViewController:YES withViewOptions:options];
           // readerView.clipsToBounds = YES;

            readerView.displayDirection = kPDFDisplayDirectionHorizontal;
            readerView.displayMode = kPDFDisplaySinglePage;
    //        [readerView zoomIn:self];
//            [readerView setDisplaysPageBreaks:YES];

            readerView.backgroundColor=[UIColor clearColor];
//            [readerView zoomIn:self];
            readerView.document = [[PDFDocument alloc]initWithURL:[NSURL fileURLWithPath:filePath]];
            self.pdfDocument = readerView.document;
//            readerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
            [readerView.document allowsPrinting];

            readerView.maxScaleFactor = 3.0;
//            readerView.minScaleFactor = 0.6;
            readerView.minScaleFactor = readerView.scaleFactorForSizeToFit;
            readerView.autoScales = YES;
          //  [readerView setDisplaysPageBreaks:YES];
          //  [readerView setDisplayBox:kPDFDisplayBoxTrimBox];
           // [readerView setLayoutMargins:pageInsets];
            
            
            
            [self addSubview:readerView];
       
    }
    [super initializeState];

}

-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    [super frameSizeChanged:frame bounds:bounds];

    if (!CGRectIsEmpty(bounds)) {
        if (readerView != nil) {
            [TiUtils setView:readerView positionRect:bounds];

            
            if (initDone == NO){
                initDone = YES;
                int frameHeight = bounds.size.height;
                int frameWidth = bounds.size.width;
                int thumbnailsize = 40;
                
                int bottomFrame = frameHeight - 200;
                int thumbFrameWidth = frameWidth - 40;
                int labelLeft = frameWidth / 2;
                int labelCenterY = bottomFrame - 50;
                int leading = 1;

                
                bottomContainer = [[UIView alloc] initWithFrame:CGRectMake(bounds.origin.x, bounds.origin.y + bounds.size.height - 100, bounds.size.width, 70)];
              //  bottomContainer.autoresizesSubviews = YES;
                
                thumbnailView = [[PDFThumbnailView alloc] initWithFrame:CGRectMake(0, 0, bottomContainer.frame.size.width, 70)];
                
                //thumbnailView = [[PDFThumbnailView alloc]init];
                thumbnailView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin |UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;

                thumbnailView.translatesAutoresizingMaskIntoConstraints = NO;
                
                [thumbnailView setLayoutMode:PDFThumbnailLayoutModeHorizontal];
                [thumbnailView setPDFView:readerView];
                
                thumbnailView.backgroundColor = [UIColor clearColor];
                UIEdgeInsets pageInsets = UIEdgeInsetsMake(0, 10, 0, 10);

                //[thumbnailView setThumbnailSize:CGSizeMake(40, 60)];
                
              //  [thumbnailView.leadingAnchor constraintEqualToAnchor:bottomContainer.leadingAnchor].active = YES;
              //   [thumbnailView.trailingAnchor constraintEqualToAnchor:bottomContainer.trailingAnchor].active = YES;
              //   [thumbnailView.bottomAnchor constraintEqualToAnchor:bottomContainer.bottomAnchor].active = YES;
               //  [thumbnailView.heightAnchor constraintEqualToConstant:60].active = YES;
              //  [thumbnailView.widthAnchor constraintEqualToConstant:((self.pdfDocument.pageCount-1) * 60)].active = YES;
                thumbnailView.contentInset = pageInsets;

                
                pageNumberContainer = [[UIView alloc] initWithFrame:CGRectMake((bounds.origin.x + (bounds.size.width/2))-(180/2), (bottomContainer.frame.origin.y - 60), 180, 40)];
                pageNumberContainer.autoresizesSubviews = YES;
                
                pageNumberLabel = [[UILabel alloc] init];
                
                CGRect currentLabelFrame = CGRectMake(0, 0, pageNumberContainer.frame.size.width, pageNumberContainer.frame.size.height);
                pageNumberLabel.frame = currentLabelFrame;
                pageNumberLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleWidth;
                pageNumberLabel.translatesAutoresizingMaskIntoConstraints = YES;
               
                CGFloat fontSize = (([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) ? 19.0f : 16.0f);

                pageNumberLabel.autoresizesSubviews = YES;
                pageNumberLabel.userInteractionEnabled = NO;
                pageNumberLabel.contentMode = UIViewContentModeRedraw;
                pageNumberLabel.textAlignment = NSTextAlignmentCenter;
                pageNumberLabel.font = [UIFont systemFontOfSize:fontSize];
                pageNumberLabel.textColor = [UIColor whiteColor];
                pageNumberLabel.backgroundColor = [UIColor colorWithWhite:0.24f alpha:0.7f];
                pageNumberLabel.text = [NSString stringWithFormat:labeltemplate, readerView.currentPage.label, (unsigned long)readerView.document.pageCount];
                

                
                [pageNumberContainer addSubview:pageNumberLabel];

            
                [bottomContainer addSubview:thumbnailView];
                
                
                
               // [thumbnailView.widthAnchor constraintEqualToConstant:scrollwidth].active = YES;
                bottomContainer.alpha = 0.0;
                //bottomContainer.hidden = YES;
                pageNumberContainer.alpha = 0.0;

                
                [self addSubview:pageNumberContainer];

                [self addSubview:bottomContainer];

                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showHideBottomView)];
                [readerView addGestureRecognizer:tap];
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PDFViewPageChangedNotification:) name:PDFViewPageChangedNotification object:readerView];
                readerView.document.delegate = self;
                readerView.delegate = self;

            }
       }
    }

}


#pragma mark - Toggle Bottom View
-(void)toggleBottomView:(CGFloat)value {
    //NSLog(@"[INFO] %@ toggleBottomView");

    CGFloat alpha = 1.0;
    if (bottomContainer.alpha > 0.0){
        alpha = 0.0;
    }


    if (value == 2.0){
        alpha = 1.0;
    }
    
    
    [UIView animateWithDuration:0.3
              delay: 0.0
              options: UIViewAnimationOptionCurveEaseInOut
              animations:^{
        self->pageNumberContainer.alpha = alpha;
        self->bottomContainer.alpha = alpha;
    } completion:nil];
    
    
    
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
   // resultCount = 0;
}
-(void)documentDidEndDocumentFind:(NSNotification *)notification
{
//    NSLog(@"[INFO] documentDidEndDocumentFind  %i", self.resultCount);
    [readerView setHighlightedSelections:[searchResultArray copy]];

    if ([(TiViewProxy*)self.proxy _hasListeners:@"searchresult"]) {
        NSMutableDictionary *event = [NSMutableDictionary dictionary];
        [event setObject:[NSNumber numberWithInt:(int)[[searchResultArray copy] count]] forKey:@"count"];

        [(TiViewProxy*)self.proxy fireEvent:@"searchresult" withObject:event propagate:NO];
    }
    [readerView goToSelection:(PDFSelection*)[[searchResultArray copy] objectAtIndex:0]];
    [self toggleBottomView:2.0];
}


-(void)didMatchString:(PDFSelection *)instance{
//    NSLog(@"[INFO] %@ didMatchString");
   // resultCount = resultCount + 1;
    instance.color = [UIColor yellowColor];

    [searchResultArray addObject:instance];
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
    [searchResultArray removeAllObjects];

    [self.pdfDocument cancelFindString];

    [self.pdfDocument beginFindString:searchText withOptions:NSCaseInsensitiveSearch];
}
-(void)showHideBottomView {
    [self toggleBottomView:1.0];
}

- (void)resetSearch {
    [searchResultArray removeAllObjects];
    [self.pdfDocument cancelFindString];
    [readerView setHighlightedSelections:nil];
}

@end
