//
//  iTetrisAppDelegate.h
//  iTetris
//
//  Created by Kumar Rangarajan on 22/01/12.
//  Copyright 2012 kumar.rangarajan@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iTetrisViewController;

@interface iTetrisAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet iTetrisViewController *viewController;

@end
