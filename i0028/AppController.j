/*
 * AppController.j
 * test
 *
 * Created by __Me__ on __Date__.
 * Copyright 2008 __MyCompanyName__. All rights reserved.
 */

@import <Foundation/CPObject.j>


/* 
 Issue 28
 
 By: nciagra
 
 The new focus rings are great. But, if you have a text field in one window
 (for example, the menu bar), and another text field in another window, there is an issue.
 Focus the first text field in the menu bar. Then, while it is still focused,
 focus the second text field in the other window. Both of them will now be "focused",
 with focus rings, and neither (sometimes one) will allow input.
 */

@implementation AppController : CPObject
{
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask];

    var label = [[CPTextField alloc] initWithFrame:CGRectMake(100.0, 100.0, 150.0, 29.0)];
    [label setStringValue:@"Hello World!"];
    [label setEditable:YES];
    [label setBezeled:YES];
    [label setBordered:YES];
    [[theWindow contentView] addSubview:label];
    
    var panel = [[CPPanel alloc] initWithContentRect:CGRectMake(200.0, 200.0, 300.0, 300.0) styleMask:nil],
        label2 = [[CPTextField alloc] initWithFrame:CGRectMake(100.0, 100.0, 150.0, 29.0)];
    
    [label2 setPlaceholderString:@"Text Field"];
    [label2 setEditable:YES];
    [label2 setBezeled:YES];
    [label2 setBordered:YES];
    [[panel contentView] addSubview:label2];
    
    [theWindow orderFront:self];
    [panel orderFront:self];
}

@end
