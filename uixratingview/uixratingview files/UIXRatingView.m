//
//  UIXRatingView.m
//  uixratingview
//
//  Copyright 2011 Umbright Consulting, Inc. All rights reserved.
//

#import "UIXRatingView.h"


@implementation UIXRatingView

@synthesize unselectedImage;
@synthesize selectedImage;
@synthesize numberOfElements;
@synthesize rating;
@synthesize delegate;

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
- (void) calculateGeometry
{
    indicatorWidth = (selectedImage.size.width < 44) ? 44 : selectedImage.size.width;
    indicatorHeight = (selectedImage.size.height < 44) ? 44 : selectedImage.size.height;;
    
}

///////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////
- (void) commonInitialization
{
    rating = 0;
    transformedViewIndex = -1;

    [self calculateGeometry];
}


///////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////
- (id) initWithNumberOfElements: (NSUInteger) numElements 
                  selectedImage: (UIImage*) selectedImg
                unselectedImage: (UIImage*) unselectedImg
{
    CGRect rect;


    
    self = [self initWithFrame:CGRectZero];
    if (self != nil)
    {
        self.unselectedImage = unselectedImg;
        self.selectedImage = selectedImg;
        self.numberOfElements = numElements;
        
//        rect.origin = CGPointZero;
//        rect.size.width = indicatorWidth * numElements;
//        rect.size.height = indicatorHeight;

        [self commonInitialization];
        [self setNeedsLayout];
        
//        self.frame = rect;
    }
    
    return self;
}

///////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////
- (void) awakeFromNib
{
    [self commonInitialization];
}

///////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////
- (void) layoutSubviews
{
    CGRect rect;
    
    rect.origin = self.frame.origin;
    rect.size.width = indicatorWidth * self.numberOfElements;
    rect.size.height = indicatorHeight;
    self.frame = rect;

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
