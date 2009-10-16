/*
 * AppController.j
 * i0151
 *
 * Created by You on October 16, 2009.
 * Copyright 2009, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>

/*
http://github.com/280north/cappuccino/issues/#issue/151

CPButtonBar rendered without a skin (by default, using aristo)
I found out, that it renders, if I change size of the parent CPView (which is 
embedded via vertical scroller). If I do resize the scroller, the skin appears. 
But it is white / without skin, before I do this.

Btw: It is not possible to resize the scroller, by using the two lines on the 
right hand side of the CPButtonBar.

Any idea?
*/

@implementation AppController : CPObject
{
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView];

    var a = [[SideBarView alloc] initWithFrame:CGRectMake(0,0,400,400)];
    [contentView addSubview:a];

    [theWindow orderFront:self];

    // Uncomment the following line to turn on the standard menu bar.
    //[CPMenu setMenuBarVisible:YES];
}

@end



@implementation SideBarView : CPView
{
}

    - (id)initWithFrame:(CGRect)aFrame
    {
        if(self = [super initWithFrame:aFrame])
        {
            var bounds = [self bounds];
            [self setBackgroundColor:[CPColor colorWithRed:213.0/255.0 green:221.0/255.0 blue:230.0/255.0 alpha:1.0]];

            var buttonbar = [[CPButtonBar alloc] initWithFrame:CGRectMake(0, 30, 200, 26)];
            [buttonbar setBackgroundColor:[CPColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]];
            [buttonbar setFrameOrigin:CGPointMake(0,CGRectGetHeight(bounds)-26)];
            //[buttonbar setFrameSize:CGPointMake(CGRectGetWidth(bounds),26)];
            [buttonbar setAutoresizingMask:CPViewWidthSizable | CPViewMinYMargin];
            [self addSubview:buttonbar];

            var button1 = [[CPButton alloc] initWithFrame:CGRectMake(10, 1, 30, 24)];
            [button1 setTitle:@"+"];
            [buttonbar addSubview:button1];
        }
        return self;
    }

@end