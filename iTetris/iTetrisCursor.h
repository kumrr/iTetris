//
//  iTetrisCursor.h
//  iTetris
//
//  Created by Kumar Rangarajan on 04/02/12.
//  Copyright 2012 kumar.rangarajan@gmail.com. All rights reserved.
//

#import "stdlib.h"
#import "iTetrisCursorShape.h"

@interface iTetrisCursor : NSObject {
    CursorBasicShape *_shape;
    int rotationIndex;
    int maxRotationValue;
    int maxPossibleShapes;
}

@property int posRow, posCol, shape;

- (id)init;
- (void)createCursorAtRow:(int)row atCol:(int)col;
- (void) rotateCursor:(BOOL)direction;
- (CursorBasicShape *) getRelatedShape;
- (int) getMaxRotationValue:(int)lShapeIndex;
- (BOOL) stateAtX:(int)x atY:(int) y;
- (int) getNumRows;
- (int) getNumCols;

@end
