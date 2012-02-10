//
//  iTetrisCell.h
//  iTetris
//
//  Created by Kumar Rangarajan on 05/02/12.
//  Copyright 2012 kumar.rangarajan@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface iTetrisCell : UIView {
    BOOL state;
}

@property BOOL cursorState;

- (void) clear;
- (void) fill;
- (BOOL) getState;
- (void) setState:(BOOL)lState;

@end
