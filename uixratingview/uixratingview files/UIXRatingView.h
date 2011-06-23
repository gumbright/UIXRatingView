//
//  UIXRatingView.h
//  uixratingview
//
//  Created by Guy Umbright on 6/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class UIXRatingView;

@protocol UIXRatingViewDelegate

- (void) ratingView:(UIXRatingView*) ratingView ratingChanged:(NSUInteger) newRating;

@end

@interface UIXRatingView : UIView 
{
    NSMutableArray* indicators;
    CGFloat indicatorWidth;
    CGFloat indicatorHeight;
    
    int transformedViewIndex;
    
    NSObject<UIXRatingViewDelegate>* delegate;
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
