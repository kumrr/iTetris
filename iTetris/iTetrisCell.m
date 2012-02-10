//
//  iTetrisCell.m
//  iTetris
//
//  Created by Kumar Rangarajan on 05/02/12.
//  Copyright 2012 kumar.rangarajan@gmail.com. All rights reserved.
//

#import "iTetrisCell.h"

@implementation iTetrisCell

@synthesize cursorState;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) clear {
    self.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];   
//    self.layer.borderColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1].CGColor;
    self.layer.borderWidth = 0.0f;
    state = FALSE;    
}

- (void) fill {
    self.backgroundColor = [UIColor colorWithRed:.1 green:.1 blue:.1 alpha:1];      
    self.layer.borderColor = [UIColor redColor].CGColor;    
    self.layer.borderWidth = 3.0f;
    state = TRUE;    
}

- (void) setState:(BOOL) lState {
    if (lState) {
        [self fill];
    }
    else {
        [self clear];
    }
}

- (BOOL) getState {
    return state;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
