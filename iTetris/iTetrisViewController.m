//
//  iTetrisViewController.m
//  iTetris
//
//  Created by Kumar Rangarajan on 22/01/12.
//  Copyright 2012 kumar.rangarajan@gmail.com. All rights reserved.
//

#import "iTetrisViewController.h"

@implementation iTetrisViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
*/

- (void)viewDidLoad {    
    NSLog(@"Entered viewDidLoad");
    UIView *myView = self.view;

    score = 0;
    
//    board = [[iTetrisGameBoard alloc] initWithView:myView withTarget:self withSelector:@selector(calledFromBoard:) withRows:16 withCols:12];
    
//    [self startGame];
    
    [super viewDidLoad];
}

- (void) startGame {
    
    // Intentionally trying to create a leak
    board = [[iTetrisGameBoard alloc] initWithView:self.view withTarget:self withSelector:@selector(calledFromBoard:) withRows:16 withCols:12];
    
    [board resetBoard];
    
    [self setScore:0];
    
    // Now start a timer to actually trigger the game
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFunction) userInfo:Nil repeats:TRUE];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)awakeFromNib {
    NSLog(@"Entered awakeFromNib");
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// This is the function that will be called evertime
// the timer fires

- (void) timerFunction {
    NSLog(@"Timer called");

    [board moveCursorDown];
}

- (void) setScore:(int)lScore {
    score = lScore;
    [scoreText setText:[NSString stringWithFormat:@"%d",lScore]];    
}

- (int) getScore {
    return score;
}

- (void) lineCleared {
    [self setScore:[self getScore]+1];
}

- (void) gameOver {
    if (timer != Nil) {
        [timer invalidate];
        timer = Nil;
    }
}

- (void) calledFromBoard:(NSString *)string {
    NSLog(string);
    if ([string isEqualToString:@"Game Over"]) {
        [self gameOver];
        
    }
    else if ([string isEqualToString:@"Line Cleared"]) {
        [self lineCleared];
    }
}

- (IBAction)upButton:(id)sender
{
    NSLog(@"Up button clicked");
    
    [board rotateCursorWithDirection:TRUE];
}

- (IBAction)downButton:(id)sender
{
    NSLog(@"Down button clicked");
    
    [board moveCursorDown];
}

- (IBAction)leftButton:(id)sender
{
    NSLog(@"Left button clicked");
    
    [board moveCursorLeft];
}

- (IBAction)rightButton:(id)sender
{
    NSLog(@"Right button clicked");
    
    [board moveCursorRight];
}

- (IBAction)startButton:(id)sender
{
    [self gameOver];
    [self startGame];
}


@end
