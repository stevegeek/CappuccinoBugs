/*
 * AppController.j
 * TextEditingBug
 *
 * Created by You on May 27, 2009.
 * Copyright 2009, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import <AppKit/AppKit.j>

@implementation EditableTextField : CPTextField
{
}

- (void)mouseDown:(CPEvent)anEvent
{
  // BUG REPORT
  if ([anEvent clickCount] == 2) {
    // These were tested in Safari 3 and Firefox 3
    // This works as expected
    //[self setEditable:YES];
    //[[self window] makeFirstResponder:self];
    //[self selectText:self];

    // This causes the text to not be selected and the field to not get focus
    [[self window] makeFirstResponder:self];
    [self setEditable:YES];
    [self selectText:self];

    // This also causes the text to not be selected, but the field does get focus
    //[self setEditable:YES];
    //[self selectText:self];
    //[[self window] makeFirstResponder:self];


  }
}

@end

@implementation AppController : CPObject
{
  EditableTextField label;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView];

    label = [[EditableTextField alloc] initWithFrame:CGRectMakeZero()];

    [label setStringValue:@"Hello World!"];
    [label setFont:[CPFont boldSystemFontOfSize:24.0]];

    [label sizeToFit];

    [label setAutoresizingMask:CPViewMinXMargin | CPViewMaxXMargin | CPViewMinYMargin | CPViewMaxYMargin];
    [label setCenter:[contentView center]];

    [contentView addSubview:label];

    [theWindow orderFront:self];
}

@end
