//
//  UIXRatingView.h
//  uixratingview
//
//  Copyright 2011 Umbright Consulting, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@class UIXRatingView;

@protocol UIXRatingViewDelegate

- (void) ratingView:(UIXRatingView*) ratingView ratingChanged:(NSInteger) newRating;

@end

@interface UIXRatingView : UIView 
{
    NSMutableArray* indicators;
    CGFloat indicatorWidth;
    CGFloat indicatorHeight;
    
    int transformedViewIndex;
    
    NSObject<UIXRatingViewDelegate>* delegate;
    NSInteger _rating;
    NSUInteger _numberOfElements;
}

@property (nonatomic, retain) UIImage* unselectedImage;
@property (nonatomic, retain) UIImage* selectedImage;
@property (nonatomic, assign) NSUInteger numberOfElements;
@property (nonatomic, assign) NSInteger rating;
@property (nonatomic, assign) NSObject<UIXRatingViewDelegate>* delegate;

- (id) initWithNumberOfElements: (NSUInteger) numElements 
                  selectedImage: (UIImage*) selectedImg
                unselectedImage: (UIImage*) unselectedImg;

@end
