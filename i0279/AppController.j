/*
 * AppController.j
 * 279
 *
 * Created by You on October 6, 2009.
 * Copyright 2009, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import <AppKit/CPView.j>


/*
 Issue 279
 
 CPScrollView clips alternating color incorrectly from CPTableView when scrolling up
 by: hammerdr
 When scrolling, the alternate background color seems to disappear. Does not seem 
 to do this for the primary color nor for a highlighted row.
 */

@implementation OLResourceView : CPView
{
}
 
- (id)initWithFrame:(CGRect)frame
{
	if(self = [super initWithFrame:frame])
	{
		var filterView = [[CPScrollView alloc] initWithFrame:CGRectMake(20,20,CGRectGetWidth(frame)/4-40, 200)];
		var filterTableView = [[CPTableView alloc] initWithFrame:CGRectMake(0,0,CGRectGetWidth([filterView bounds]), 200)];
		var filterTableColumn = [[CPTableColumn alloc] initWithIdentifier:@"filterColumn"];
		[filterTableColumn setWidth: CGRectGetWidth([filterTableView bounds])];
		[filterTableView addTableColumn: filterTableColumn];
		[filterTableView setUsesAlternatingRowBackgroundColors:YES];
		[filterView setDocumentView:filterTableView];
		[filterTableView setDataSource:self];
		[self addSubview:filterView];
	}
	return self;
}
 
- (int)numberOfRowsInTableView:(CPTableView)view
{
	return 50;
}
 
- (id)tableView:(CPTableView)view objectValueForTableColumn:(CPTableColumn)column row:(int)row
{	
	return "Bob";
}
 
@end


@implementation AppController : CPObject
{
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView];
        
    var r = [[OLResourceView alloc] initWithFrame:CGRectMake(10,10,600,600)];
    
    [contentView addSubview:r];
    
    [theWindow orderFront:self];
}

@end