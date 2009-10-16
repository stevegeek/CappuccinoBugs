/*
 * AppController.j
 * i0040
 *
 * Created by You on October 16, 2009.
 * Copyright 2009, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>

/*
 Issue #41
 
 http://github.com/280north/cappuccino/issues/#issue/41
 
 "CPSplitView doesn't honor splitView:constrainMinCoordinate:ofSubviewAt: when resizing window"
 
 test by balthazar
 
 Cocoa does honor it so cappuccino should emulate this behavior.
*/ 
 
@implementation AppController : CPObject
{
}
 
- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView];
 
    var	splitView = [[CPSplitView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([contentView bounds]), CGRectGetHeight([contentView bounds]))];
	[splitView setDelegate:self];
	[splitView setVertical:YES]; 
	[splitView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable ]; 
	[contentView addSubview:splitView];
 
	var leftView = [[CPView alloc] initWithFrame:CGRectMake(0, 0, 200, CGRectGetHeight([splitView bounds]))];
	var rightView = [[CPView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([splitView bounds]) - 200, CGRectGetHeight([splitView bounds]))];
	[rightView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable ]; 
 
	[splitView addSubview:leftView];
	[splitView addSubview:rightView];
    	
    	
 
    [theWindow orderFront:self];
}
 
- (int)splitView:(CPSplitView)splitView constrainMinCoordinate:(int)minCoord ofSubviewAt:(int)index
{
    console.log("I'm here") ;
    if (index == 0) {
        return 200;
    }
    else {
        return minCoord;
    }
}
 
@end
 
