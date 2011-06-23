//
//  uixratingviewAppDelegate.h
//  uixratingview
//
//  Created by Guy Umbright on 6/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class uixratingviewViewController;

@interface uixratingviewAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet uixratingviewViewController *viewController;

@end
