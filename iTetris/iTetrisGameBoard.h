//
//  iTetrisGameBoard.h
//  iTetris
//
//  Created by Kumar Rangarajan on 04/02/12.
//  Copyright 2012 kumar.rangarajan@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iTetrisCell.h"
#import "iTetrisCursor.h"

@interface iTetrisGameBoard : NSObject {
    UIView *boardView, *parentView;
    int boardWidth, boardHeight;
    NSMutableArray *cells;
    iTetrisCursor *cursor;
    id _target;
    SEL _selector;
    BOOL createNewCursorFlag;
}

@property int maxRows, maxCols;

- (id)initWithView:(UIView *)view withTarget:(id) target withSelector:(SEL) callback withRows:(int)rows withCols:(int)cols;
- (BOOL) fillBoardWithType:(BOOL)flag;
- (BOOL) createCursor;
- (BOOL) moveCursorRight;
- (BOOL) moveCursorLeft;
- (BOOL) moveCursorDown;
- (BOOL) rotateCursorWithDirection:(BOOL)direction;
- (void) resetBoard; 

- (void) _reDrawBoard;
- (BOOL) _drawCursor;
- (BOOL) _drawCursorAtRow:(int) row atCol:(int) col returnAfterChecking:(BOOL) flag;
- (void) _checkIfRowFilled;
- (void) _moveAboveRowsDownToRow:(int) row;
- (void) _clearRow:(int)row;


@end
