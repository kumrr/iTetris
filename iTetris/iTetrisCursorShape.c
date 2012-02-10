//
//  iTetrisCursorShape.c
//  iTetris
//
//  Created by Kumar Rangarajan on 08/02/12.
//  Copyright 2012 kumar.rangarajan@gmail.com. All rights reserved.
//

#import "iTetrisCursorShape.h"

CursorBasicShape squareCursorShape[] = {
    {
        {1,1,1,1},
        2,
        2
    },
    {
        {},
        0,
        0
    }
};

CursorBasicShape lCursorShape[] = {
    {
        {1,1,1,0,1,0},
        3,
        2
    },
    {
        {1,1,0,1,0,1},
        3,
        2
    },
    {
        {1,1,1,1,0,0},
        2,
        3
    },
    {
        {0,0,1,1,1,1},
        3,
        2
    },
    {
        {1,0,1,0,1,1},
        3,
        2
    },
    {
        {0,1,0,1,1,1},
        3,
        2
    },
    {
        {},
        0,
        0
    }    
};

CursorBasicShape tCursorShape[] = {
    {
        {1,1,1,0,1,0},
        2,
        3
    },
    {
        {0,1,1,1,0,1},
        3,
        2
    },
    {
        {0,1,0,1,1,1},
        2,
        3
    },
    {
        {1,0,1,1,1,0},
        2,
        3
    },    
    {
        {},
        0,
        0
    }    
};

CursorBasicShape lineCursorShape[] = {
    {
        {1,1,1,1},
        4,
        1
    },
    {
        {1,1,1,1},
        1,
        4
    },
    {
        {},
        0,
        0
    }    
};

void *cursorShape[] = {
    squareCursorShape, 
    lCursorShape,
    lineCursorShape,
    tCursorShape
};

int numberOfShapes() {
    return sizeof(cursorShape)/sizeof(CursorBasicShape *);
}

int numberOfRotations(CursorBasicShape *shapeTmp) {
    int count = 0;
    
    while ((shapeTmp++)->maxCols != 0) count++;
    
    return count;    
}
