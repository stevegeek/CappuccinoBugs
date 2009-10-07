/*
 * AppController.j
 * i0273
 *
 * Created by You on October 8, 2009.
 * Copyright 2009, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>


/*
 Issue: 273
 By: cocoadev
 http://github.com/280north/cappuccino/issues/#issue/273
 
 "When you capture an event, like with -mouseDown:(CPEvent)event, the -timestamp
 method of this event returns an incorrect CPTimeInterval. This is because in
 FireFox, unlike webkit, the js property domEvent.timeStamp returns a duration
 in ms since a reference date != 01-01-1970. For example,on my system with
 FireFox 3.5, the ref date is August 9 2009. So I assume the ref date changes
 at each release."
 */

@implementation AppController : CPObject
{
	var theWindow;
	var menu;
	var view;
	var textField;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    theWindow = [[MyWindow alloc] initWithContentRect:CGRectMake(50,50,500,500) styleMask:CPResizableWindowMask],
        contentView = [theWindow contentView];
	
	textField = [[CPTextField alloc] initWithFrame:CGRectMake(10,50,400,70)];
	[textField setAutoresizingMask:CPViewWidthSizable];
	[textField setSelectable:YES];
	[textField setBezeled:NO];
	[textField setDrawsBackground:YES];
	[textField setBackgroundColor:[CPColor blackColor]];
	[textField setTextColor:[CPColor greenColor]];
	[textField setStringValue:@"Click anywhere"];
	[contentView addSubview:textField];
/*
	view = [[CPView alloc] initWithFrame:CGRectMake(10,0,300,0)];
	[view setBackgroundColor:[CPColor redColor]];
	[contentView addSubview:view];
	
	var button = [[Button alloc] initWithFrame:CGRectMake(350,50,100,32)];
	[button setTitle:"title"];
	[contentView addSubview:button];
*/	
//	var timer = [CPTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(logFirstResponder:) userInfo:nil repeats:YES];

	menu = [[CPMenu alloc] init];
	[menu addItemWithTitle:"toto" action:nil keyEquivalent:@"a"];
	[menu addItemWithTitle:"tata" action:nil keyEquivalent:@"b"];
	
	[theWindow orderFront:self];
}

- (void)logFirstResponder:(id)sender
{
	CPLogConsole([theWindow firstResponder]);
}

- (CPMenu)menu
{
	return menu;
}

- (CPView)view
{
	return view;
}

- (CPView)textField
{
	return textField;
}
@end


@implementation MyWindow : CPWindow
{
}

- (void)mouseDown:(CPEvent)event
{
	var console = [[CPApp delegate] textField];
	
	var timeIntervalSince1970 = [[CPDate date] timeIntervalSince1970];
	var capturedTimestamp = [event timestamp];
	var currentEventTimestamp = [[CPApp currentEvent] timestamp];
    
	[console setStringValue:("[[CPDate date] timeIntervalSince1970]	= " + timeIntervalSince1970 +"\n[event timestamp]						= " + 
capturedTimestamp    + "\n[[CPApp currentEvent] timestamp]		= " + currentEventTimestamp)];

//    var anEvent = [CPEvent mouseEventWithType:CPRightMouseDown location:CGPointMake(20,20) modifierFlags:0 timestamp:currEventTs windowNumber:[self windowNumber] context:nil eventNumber:1 clickCount:1 pressure:0];
//	[CPMenu popUpContextMenu:[[CPApp delegate] menu] withEvent:anEvent forView:view];
}
@end

@implementation CPEvent (Description)

- (CPString)description
{
	return "Type="+[self type]+"\nmodifiers="+[self modifierFlags]+"\ntimestamp="+[self timestamp]+"\nwindowNumber="+[self windowNumber]+"\nclickCount="+[self clickCount]+"\npressure="+[self pressure];

}
@end
