/*
 * AppController.j
 * 281
 *
 * Created by You on October 7, 2009.
 * Copyright 2009, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>

/* Issue 281:
   By:  eboehnisch
 
   "I am listening for the CPWindowWillCloseNotification notification and
   compare the object value with my CPPanel to detect whether it is my window
   that closed or not. When using the uncompiled code in my project it works
   as expected. When compiling it through rake, this no longer works but
   delivers "null" as the object value.
   In addition, programmatically closing the panel using [myPanel close] has
   no effect. Manually closing closes the panel but, as said,
   does not send the correct notification. In the uncompiled code,
   it works as expected."
 */



@implementation MyPanel : CPPanel
{
}

- (void)notify
{
    alert("fired");
}

@end


@implementation AppController : CPObject
{
    CPPanel _p;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView];

    _p = [[MyPanel alloc] initWithContentRect:CGRectMake(30,30,100,100) styleMask:CPTitledWindowMask|CPClosableWindowMask];
    
    [[CPNotificationCenter defaultCenter] addObserver:_p selector:@selector(notify) name:@"CPWindowWillCloseNotification" object:nil];
    
    [theWindow orderFront:self];
    [_p orderFront:self];
    
    
    var b = [[CPButton alloc] initWithFrame:CGRectMake(200,10,150,25)];
    [b setTitle:@"Close window"];
    [b setAction:@selector(closewindow:)];
    [contentView addSubview:b];
}

- (void)closewindow:(id)sender
{
    [_p close];
}

@end


