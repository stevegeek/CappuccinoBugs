/*
 * AppController.j
 * NewApplication
 *
 * Created by You on May 21, 2009.
 * Copyright 2009, Your Company All rights reserved.
 */
 
@import <Foundation/CPObject.j>

/*
 Issue: 190
 By: glejeune
 http://github.com/280north/cappuccino/issues/#issue/190
 
 Test via chandlerkent
 "CPWebView does not resize when window is resized.setAutoresizingMask: with 
 CPViewHeightSizable | CPViewWidthSizable does not seem to work."
 */
 
@implementation AppController : CPObject
{
}
 
- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView];
 
    var webView = [[CPWebView alloc] initWithFrame:[contentView bounds]];
    [webView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
    
    [webView setMainFrameURL:@"http://www.cappuccino.org"];
 
    [contentView addSubview:webView];
 
    [theWindow orderFront:self];
 
    // Uncomment the following line to turn on the standard menu bar.
    //[CPMenu setMenuBarVisible:YES];
}
 
@end
