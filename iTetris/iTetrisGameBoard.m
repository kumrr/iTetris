//
//  iTetrisGameBoard.m
//  iTetris
//
//  Created by Kumar Rangarajan on 04/02/12.
//  Copyright 2012 kumar.rangarajan@gmail.com. All rights reserved.
//

#import "iTetrisGameBoard.h"

@implementation iTetrisGameBoard

@synthesize maxRows, maxCols;

- (id)initWithView:(UIView *)view withTarget:(id) target withSelector:(SEL) selector withRows:(int)rows withCols:(int)cols
{
    self = [super init];
    if (self) {
        self.maxRows = rows;
        self.maxCols = cols;
        _target = target;
        _selector = selector;
        parentView = view;

        CGRect viewBounds = view.bounds;
        
        // These are X,Y relative to the parent view,
        // and we dont really want to preserve it
        int boardX = viewBounds.origin.x+1;
        int boardY = view.bounds.origin.y+55;
        
        // These are properties of the board 
        boardWidth = view.bounds.size.width-2;
        boardHeight = view.bounds.size.height-(105+57);
        
        // Create the initial 'rect' area and color it
        boardView = [[UIView alloc] initWithFrame:CGRectMake(boardX, boardY, boardWidth, boardHeight)];
        boardView.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];
        [view  addSubview:boardView];
        
        // Break it into virtual cells based on the 
        // specified rows/cols
        cells = [NSMutableArray array];
        
        [cells retain]; // Will get auto-released otherwise
        
        int widthOfCell = boardWidth/cols;
        int heightOfCell = boardHeight/rows;
        int cellX = 0, cellY = 0;
        
        for (int i=0; i<rows; i++) {
            cellY = i * heightOfCell;
            for (int j = 0; j < cols; j++) {
                cellX = j * widthOfCell;
                iTetrisCell *cell = [[iTetrisCell alloc] initWithFrame:CGRectMake(cellX, cellY, widthOfCell, heightOfCell)];
                [cell setState:FALSE];
                cell.cursorState = FALSE;
                [cells addObject:cell];
                [boardView addSubview:cell];
                [cell release]; // retained by parent view
            }
        }
        
        cursor = [[iTetrisCursor alloc] init];
                
        [boardView release]; // retained by parent view
    }
    
    return self;
}

- (void) _reDrawBoard {
    for(int i=0; i < maxRows; i++) {
        for (int j=0; j < maxCols; j++) {
            iTetrisCell *cell = [cells objectAtIndex:(i*j)+j];
            if ([cell getState]) {
                [cell fill];
            }
            else {
                [cell clear];
            }
        }
    }
}

- (void) resetBoard {
    for(int i=0; i < maxRows; i++) {
        for (int j=0; j < maxCols; j++) {
            iTetrisCell *cell = [cells objectAtIndex:(i*maxCols)+j];
            
            [cell clear];
            cell.cursorState = FALSE;
        }
    }
    
    createNewCursorFlag = TRUE;
}

// Test function.. will not be really used for real game
- (BOOL) fillBoardWithType:(BOOL)flag {

    for(int i=0; i < maxRows; i++) {
        for (int j=0; j < maxCols; j++) {
            if (flag) {
                if (((i*maxRows)+j) % 2) {
                    iTetrisCell *cell = [cells objectAtIndex:(i*maxCols)+j];
                    [cell clear];
                }
                else {
                    iTetrisCell *cell = [cells objectAtIndex:(i*maxCols)+j];
                    [cell fill];                    
                } 
            }
            else {
                if (((i*maxRows)+j) % 2) {
                    iTetrisCell *cell = [cells objectAtIndex:(i*maxCols)+j];
                    [cell fill];
                }
                else {
                    iTetrisCell *cell = [cells objectAtIndex:(i*maxCols)+j];
                    [cell clear];                    
                }
            }
        }
    } 
    
    return !flag;
}

- (BOOL) _drawCursorAtRow:(int)row atCol:(int)col returnAfterChecking:(BOOL)flag {
    
    // Trial run to see if the cursor can be created on
    // the board
    
    if (row < 0 || col < 0 ||
        ((row + [cursor getNumRows]) > maxRows) ||
        ((col + [cursor getNumCols]) > maxCols)) {
        return FALSE;
    }
    
    for (int i = row; i < (row + [cursor getNumRows]); i++) {
        for (int j = col; j < (col + [cursor getNumCols]); j++) {

            BOOL cursorState = [cursor stateAtX:(i-row) atY:(j-col)];

            iTetrisCell *cell = [cells objectAtIndex:(i*self.maxCols)+j];            
            
            // If cursor's cell is supposed to be ON in a 
            // position of the board which is already ON, 
            // then it means that we cannot create the 
            // cursor at that point! So we return false
            if (cell == Nil || (!cell.cursorState && ([cell getState] && cursorState))) {
                return FALSE;
            }            
        }
    }
    
    // Was the caller only intereted to know if the cursor
    // can be drawn here? If yes, just return TRUE.
    // We expect the caller to invoke this function again
    // with the flag FALSE if he really wants to draw
    // the cursor
    if (flag) { // This was a check only run!
        return TRUE;
    }

    // Real run to actually draw the cursor!
    for (int i = row; i < (row + [cursor getNumRows]); i++) {
        for (int j = col; j < (col + [cursor getNumCols]); j++) {
            iTetrisCell *cell = [cells objectAtIndex:(i*self.maxCols)+j];            
            
            BOOL cursorState = [cursor stateAtX:(i-row) atY:(j-col)];

            if (cursorState) {
                [cell setState:cursorState];
                cell.cursorState = TRUE;
            }
        }
    }
    
    return TRUE;
}

- (BOOL) _drawCursor {
    return [self _drawCursorAtRow:cursor.posRow atCol:cursor.posCol returnAfterChecking:FALSE];
}

- (void) _eraseCursor {
    for (int i = cursor.posRow; i < (cursor.posRow + [cursor getNumRows]); i++) {
        for (int j = cursor.posCol; j < (cursor.posCol +[cursor getNumCols]); j++) {
            iTetrisCell *cell = [cells objectAtIndex:(i*self.maxCols)+j];      
            BOOL cursorState = [cursor stateAtX:(i-cursor.posRow) atY:(j-cursor.posCol)];
            
            if (cursorState) {
                [cell setState:FALSE];
                cell.cursorState = FALSE;
            }
        }
    }
}

- (void) _eraseCursorState {
    for (int i = cursor.posRow; i < (cursor.posRow + [cursor getNumRows]); i++) {
        for (int j = cursor.posCol; j < (cursor.posCol +[cursor getNumCols]); j++) {
            iTetrisCell *cell = [cells objectAtIndex:(i*self.maxCols)+j];      
            
            cell.cursorState = FALSE;
        }
    }
}

- (BOOL) createCursor {
    
    // Remove the state of the current cursor from
    // the board
    [self _eraseCursorState];
    
    // Now create a new cursor in the new position
    
    [cursor createCursorAtRow:0 atCol:maxCols/2];
    
    // Try to draw the cursor. If that fails, then this
    // call also fails
    if (![self _drawCursor]) {
        // Cannot draw new cursor! Means we cannot create
        // a new cursor! Game over! Notify the view 
        // controller
        [_target performSelector:_selector withObject:@"Game Over"];
        return FALSE;
    }
    
    return TRUE;
}

- (void) _clearRow:(int)row {
    for (int j = 0; j < self.maxCols; j++) {
        iTetrisCell *cell = [cells objectAtIndex:(row*self.maxCols)+j];
        [cell setState:FALSE];
    }
}

- (void) _moveAboveRowsDownToRow:(int) row {
    
    if (row < 0 || row > self.maxRows) return;
    
    for (int i = row - 1; i >= 0; i--) {
        for (int j = 0; j < self.maxCols; j++) {
            iTetrisCell *srcCell = [cells objectAtIndex:(i*self.maxCols)+j];
            iTetrisCell *dstCell = [cells objectAtIndex:((i+1)*self.maxCols)+j];
            
            [dstCell setState:[srcCell getState]];
        }
    }
    
    // Finally clear the top row
    [self _clearRow:0];
}

- (void) _checkIfRowFilled {
    int count = 0;
    
    for (int i = 0; i < self.maxRows; i++) {
        BOOL state = TRUE;
        for (int j = 0; j < self.maxCols; j++) {
            iTetrisCell *cell = [cells objectAtIndex:(i*self.maxCols)+j];
            // If any cell in this row is not ON then
            // just move to the next row
            if (![cell getState]) {
                state = FALSE;
                break;
            }
        }        
        if (state) {
            count++;
            [self _moveAboveRowsDownToRow:i];
            [_target performSelector:_selector withObject:@"Line Cleared"];
        }
    }    
}

- (BOOL) moveCursorToX:(int) newX toY:(int)newY {
    
    // Check if we can draw the cursor at the new
    // position
    if (![self _drawCursorAtRow:newX atCol:newY returnAfterChecking:TRUE]) {
        return FALSE;
    }
    
    // erase the previous cursor
    [self _eraseCursor];
    
    cursor.posRow = newX;
    cursor.posCol = newY;
    
    // Do the real drawing of cursor
    [self _drawCursor];
    
    return TRUE;
}

- (BOOL) moveCursorLeft {        
    return [self moveCursorToX:cursor.posRow toY:(cursor.posCol-1)];
}

- (BOOL) moveCursorRight {
    return [self moveCursorToX:cursor.posRow toY:(cursor.posCol+1)];
}

- (BOOL) moveCursorDown {
    
    if (createNewCursorFlag) {
        createNewCursorFlag = FALSE;
        return [self createCursor];
    }

    if ([self moveCursorToX:cursor.posRow+1 toY:cursor.posCol] == FALSE) {
        [self _eraseCursorState];
        [self _checkIfRowFilled];
        createNewCursorFlag = TRUE;
        return FALSE;
    }
    
    return TRUE;
}

- (BOOL) rotateCursorWithDirection:(BOOL) direction {
    [cursor rotateCursor:direction];
    
    if (![self _drawCursorAtRow:cursor.posRow atCol:cursor.posCol returnAfterChecking:TRUE]) {
        // Cannot draw cursor at current position! 
        // set the rotation to the previous value
        [cursor rotateCursor:!direction];
        return FALSE;
    }

    // erase the previous cursor
    [cursor rotateCursor:!direction];
    [self _eraseCursor];
    [cursor rotateCursor:direction];

    // now the cursor is drawn rotated
    [self _drawCursor];
    
    return TRUE;
}

@end
