//
//  iTetrisCursor.m
//  iTetris
//
//  Created by Kumar Rangarajan on 04/02/12.
//  Copyright 2012 kumar.rangarajan@gmail.com. All rights reserved.
//

#import "iTetrisCursor.h"

@implementation iTetrisCursor

@synthesize posRow;
@synthesize posCol;
@synthesize shape;


- (id)init
{
    maxPossibleShapes = numberOfShapes();
    // default invalid values
    self.shape = rotationIndex = maxRotationValue = -1; 
    _shape = Nil;
    return self;
}

- (CursorBasicShape *) getRelatedShape {
    CursorBasicShape *shapeTmp = (CursorBasicShape *) cursorShape[self.shape];
    return &shapeTmp[rotationIndex];    
}

- (int) getMaxRotationValue:(int)lShapeIndex {
    int count = 0;
    CursorBasicShape *shapeTmp = (CursorBasicShape *) cursorShape[lShapeIndex];
    
    return numberOfRotations(shapeTmp);
    while ((shapeTmp++)->maxCols != 0) count++;
    
    return count;
}

- (void) createCursorAtRow:(int)row atCol:(int)col {
    int shapeIndex = arc4random() % maxPossibleShapes;
    
    self.posRow = row;
    self.posCol = col;
    self.shape = shapeIndex;
    rotationIndex = 0;
    maxRotationValue = [self getMaxRotationValue:(int)shapeIndex];
    _shape = [self getRelatedShape];
}

- (void) rotateCursor:(BOOL)direction {
    // direction : TRUE (clockwise) FALSE (anti-clockwise)
    if (direction) {
        if (++rotationIndex >= maxRotationValue)
            rotationIndex = 0;
    }
    else {
        if (--rotationIndex < 0)
            rotationIndex = maxRotationValue - 1;        
    }
    
    _shape = [self getRelatedShape];
}

- (BOOL) stateAtX:(int)x atY:(int) y {
    int index = (x * [self getNumCols]) + y;
    
    if (index >= ([self getNumCols] * [self getNumRows]))
        return FALSE;
    
    return (BOOL) _shape->pattern[index];
}

- (int) getNumRows {
    return (_shape != (CursorBasicShape *) Nil) ? _shape->maxRows : Nil;
}

- (int) getNumCols {
    return _shape ? _shape->maxCols : Nil;
}

@end
