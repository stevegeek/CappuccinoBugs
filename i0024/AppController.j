/*
 * AppController.j
 * i0024
 *
 * Created by You on October 16, 2009.
 * Copyright 2009, Your Company All rights reserved.
 */


/*
 http://github.com/280north/cappuccino/issues#issue/24

"[myButton setBezelStyle:CPHUDBezelStyle];
 should produces a HUD style button (similar to the 280Slides Media Browser buttons) but does not."
*/

@import <Foundation/CPObject.j>


@implementation AppController : CPObject
{
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView];

    var button = [CPButton buttonWithTitle:@"Title"];
    [button setBezelStyle:CPHUDBezelStyle];
    
    [contentView addSubview:button];

    [theWindow orderFront:self];

}

@end
