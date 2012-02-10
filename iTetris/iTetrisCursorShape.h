//
//  iTetrisCursorShape.h
//  iTetris
//
//  Created by Kumar Rangarajan on 04/02/12.
//  Copyright 2012 kumar.rangarajan@gmail.com. All rights reserved.
//

#ifndef iTetris_iTetrisCursorShape_h
#define iTetris_iTetrisCursorShape_h

#define RANDOM_INT(min, max) ((min) + arc4random() % ((max+1) – (min)))

typedef struct CursorBasicShape {
    int pattern[6];
    int maxRows;
    int maxCols;
} CursorBasicShape;

extern void *cursorShape[];

int numberOfShapes();
int numberOfRotations(CursorBasicShape *shapeTmp);


#endif
