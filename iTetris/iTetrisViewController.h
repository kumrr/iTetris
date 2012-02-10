//
//  iTetrisViewController.h
//  iTetris
//
//  Created by Kumar Rangarajan on 22/01/12.
//  Copyright 2012 kumar.rangarajan@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iTetrisGameBoard.h"

@interface iTetrisViewController : UIViewController {
    IBOutlet UITextField *scoreText, *timerText;
    iTetrisGameBoard *board;
    NSTimer *timer;
    int score;
}

-(IBAction)upButton:(id)sender;
-(IBAction)downButton:(id)sender;
-(IBAction)leftButton:(id)sender;
-(IBAction)rightButton:(id)sender;
-(IBAction)startButton:(id)sender;
-(void) timerFunction;
-(void) startGame;
- (void) setScore:(int)lScore;
- (int) getScore;

@end
