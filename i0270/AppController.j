/*
 * AppController.j
 * i0270
 *
 * Created by You on October 8, 2009.
 * Copyright 2009, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
 
/*
 Issue: 270
 By: saikat
 http://github.com/280north/cappuccino/issues/#issue/270
 
 "This is a regression bug (just tried with 0.7.1 and the behavior works). If I 
 add a separator CPMenuItem, anything I put after that separator does not move 
 with the window's width and just gets cut off."
 */
 
@implementation AppController : CPObject
{
}
 
- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView];
 
    var label = [[CPTextField alloc] initWithFrame:CGRectMakeZero()];
 
    [label setStringValue:@"Hello World!"];
    [label setFont:[CPFont boldSystemFontOfSize:24.0]];
 
    [label sizeToFit];
 
    [label setAutoresizingMask:CPViewMinXMargin | CPViewMaxXMargin | CPViewMinYMargin | CPViewMaxYMargin];
    [label setCenter:[contentView center]];
 
    [contentView addSubview:label];
 
    [theWindow orderFront:self];
 
    // Uncomment the following line to turn on the standard menu bar.
    [CPMenu setMenuBarVisible:YES];
    var menu = [[CPApplication sharedApplication] mainMenu];
    [menu addItem:[CPMenuItem separatorItem]];
    [menu addItemWithTitle:"Login" action:@selector(login) keyEquivalent:nil];
    
}
 
- (void)login
{
}
 
@end