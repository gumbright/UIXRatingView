//
//  UIXRatingView.m
//  uixratingview
//
//  Created by Guy Umbright on 6/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIXRatingView.h"


@implementation UIXRatingView

@synthesize unselectedImage;
@synthesize selectedImage;
@synthesize numberOfElements;
@synthesize rating;
@synthesize delegate;

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}

///////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////
- (NSString*) description
{
    return [NSString stringWithFormat:@"rating=%d numberOfElements=%u selectedImage=%@ unselectedImage=%@",self.rating,self.numberOfElements,self.selectedImage,self.unselectedImage];
}

///////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////
- (id) initWithNumberOfElements: (NSUInteger) numElements 
                  selectedImage: (UIImage*) selectedImg
                unselectedImage: (UIImage*) unselectedImg
{
    CGRect rect;
    
    rect.origin = CGPointZero;
    indicatorWidth = (selectedImage.size.width < 44) ? 44 : selectedImage.size.width;
    rect.size.width = indicatorWidth * numElements;
    
    rect.size.height = (selectedImage.size.height < 44) ? 44 : selectedImage.size.height;
    indicatorHeight = rect.size.height;
    
    self = [self initWithFrame:rect];
    if (self != nil)
    {
        self.unselectedImage = unselectedImg;
        self.selectedImage = selectedImg;
        self.numberOfElements = numElements;
        self.rating = -1;
        transformedViewIndex = -1;
    }
    
    return self;
}

///////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////
- (void) layoutSubviews
{
    if (indicators == nil)
    {
        indicators = [[NSMutableArray arrayWithCapacity:self.numberOfElements] retain];
        
        for (int ndx=0; ndx < self.numberOfElements; ++ndx)
        {
            UIImageView* iv = [[UIImageView alloc] initWithImage:unselectedImage];
            iv.userInteractionEnabled = NO;
            iv.contentMode = UIViewContentModeCenter;
            
            CGRect r = CGRectMake(indicatorWidth * ndx, 0, indicatorWidth, indicatorHeight);
            iv.frame = r;
            [self addSubview:iv];
            [indicators addObject:iv];
            [iv release];
        }
    }
}

///////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////
- (void)dealloc
{
    self.unselectedImage = nil;
    self.selectedImage = nil;
    [indicators release];
    [super dealloc];
}

///////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////
- (void) updateDisplayForRating
{
//    NSLog(@"rating=%u",self.rating);
    for (int ndx = 0; ndx < self.numberOfElements; ++ndx)
    {
        UIImageView* iv = [indicators objectAtIndex:ndx];
        
        if (rating < 0)
        {
            iv.image = self.unselectedImage;
        }
        else
        {
            if (ndx <= self.rating-1)
            {
                iv.image = self.selectedImage;
            }
            else
            {
                iv.image = self.unselectedImage;
            }
        }
    }
}

///////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////
- (void) transformViewAtIndex:(int) index
{
    CGAffineTransform transform;
    
    if (index != transformedViewIndex)
    {
        if (transformedViewIndex >= 0)
        {
            UIView* v = [indicators objectAtIndex:transformedViewIndex];
            v.transform = CGAffineTransformIdentity;
            transformedViewIndex = -1;
        }
        
        if (index >= 0)
        {
            //apply new
            transformedViewIndex = index;
            transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
            UIView* v = [indicators objectAtIndex:index];
            v.transform = transform;
            [v setNeedsDisplay];
        }
    }
}
///////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count] == 1)
    {
        UITouch* touch = [touches anyObject];
        CGPoint pt = [touch locationInView:self];
//        NSLog(@"tb %@",NSStringFromCGPoint(pt));
        int n = pt.x / indicatorWidth;
        self.rating = n+1;
        [self transformViewAtIndex:n];
        [self updateDisplayForRating];
    }
}

///////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count] == 1)
    {
        UITouch* touch = [touches anyObject];
        CGPoint pt = [touch locationInView:self];
//        NSLog(@"tm %@",NSStringFromCGPoint(pt));
        int n = pt.x / indicatorWidth;
        self.rating = n+1;
        [self transformViewAtIndex:n];
        [self updateDisplayForRating];
    }
    
}

///////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self transformViewAtIndex:-1];
}

///////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self transformViewAtIndex:-1];
}


@end
