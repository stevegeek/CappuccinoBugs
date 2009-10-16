/*
 * AppController.j
 * i0110
 *
 * Created by You on October 16, 2009.
 * Copyright 2009, Your Company All rights reserved.
 */

/*
 http://github.com/280north/cappuccino/issues/#issue/110
 By: boucher
 
 "Setting menu bar title after telling the menu bar to display itself causes 
 incorrect shadow color"
 "This is likely a bug in _CPImageAndTitleView. It's triggered by calling 
 [CPMenu setMenuBarVisible:YES] and then [CPMenu setMenuBarTitle:"foo"]. 
 Reverse the order, and the shadow is the correct color."

*/
@import <Foundation/CPObject.j>


@implementation AppController : CPObject
{
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView];

    [theWindow orderFront:self];

    //[CPMenu setMenuBarTitle:"foo"];
    //[CPMenu setMenuBarVisible:YES];
    
    [CPMenu setMenuBarVisible:YES];
    [CPMenu setMenuBarTitle:"foo"];    
    
    alert("look at menu bar title, then change order of setMenuBarVisible and setMenuBarTitle");
    
}

@end
