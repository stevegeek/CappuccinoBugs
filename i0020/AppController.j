/*
 * AppController.j
 * i0020
 *
 * Created by You on October 16, 2009.
 * Copyright 2009, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>


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
    
    var a = [[CPString JSONFromObject: [ null ] ]];
    
    alert ("A = " + a);
    
    var b = [CPString stringWithString:[[CPString JSONFromObject: [ null ] ]]];
    
    alert ("B = " + b);

    // Uncomment the following line to turn on the standard menu bar.
    //[CPMenu setMenuBarVisible:YES];
}

@end
