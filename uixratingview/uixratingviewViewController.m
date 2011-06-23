//
//  uixratingviewViewController.m
//  uixratingview
//
//  Created by Guy Umbright on 6/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "uixratingviewViewController.h"

@implementation uixratingviewViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIXRatingView* rv = [[UIXRatingView alloc] initWithNumberOfElements:5 
                                                          selectedImage:[UIImage imageNamed:@"bell_on"] 
                                                        unselectedImage:[UIImage imageNamed:@"bell_off"]];
    CGRect r = rv.frame;
    r.origin = CGPointMake(10, 10);
    rv.frame = r;
    
    [self.view addSubview:rv];
    [rv release];

    rv = [[UIXRatingView alloc] initWithNumberOfElements:10 
                                                          selectedImage:[UIImage imageNamed:@"arrow_up_64"] 
                                                        unselectedImage:[UIImage imageNamed:@"arrow_down_64"]];
    r = rv.frame;
    r.origin = CGPointMake(10, 100);
    rv.frame = r;
    
    [self.view addSubview:rv];
    [rv release];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
