/*
 * AppController.j
 * CPScrollViewBug
 *
 * Created by You on May 27, 2009.
 * Copyright 2009, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import <AppKit/CPScrollView.j>


@implementation AppController : CPObject
{
  CPArray content;
  var textCollectionView;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView];

    textCollectionView = [[CPCollectionView alloc]
			       initWithFrame:CGRectMake(0.0, 0.0, 100, 100)];
    [textCollectionView setMinItemSize:CGSizeMake(100, 20)];
    [textCollectionView setMaxItemSize:CGSizeMake(100, 20)];

    var itemPrototype = [[CPCollectionViewItem alloc] init];

    [itemPrototype setView:[[TextIconView alloc] initWithFrame:CGRectMakeZero()]];

    [textCollectionView setItemPrototype:itemPrototype];
    content = ["Item 1", "Item 2", "Item 3"];
    [textCollectionView setContent:content];

    // Scroll view to contain the widgets collection
    textCollectionContainer = [[CPScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 100)];
    [textCollectionContainer setAutohidesScrollers:YES];
    [textCollectionContainer setHasHorizontalScroller:NO];
    [textCollectionContainer setDocumentView:textCollectionView];
    [textCollectionContainer setBackgroundColor:[CPColor lightGrayColor]];
  
    [contentView addSubview:textCollectionContainer];

    var addScreenButton = [CPButton buttonWithTitle:"+"];
    [addScreenButton setFrameOrigin:CGPointMake(200 - [addScreenButton bounds].size.width - 5,
						100 - [addScreenButton bounds].size.height - 5)];
    [addScreenButton setAutoresizingMask: CPViewMaxXMargin | CPViewMaxYMargin];
    [addScreenButton setTarget:self];
    [addScreenButton setAction:@selector(addNewScreen)];
    [contentView addSubview:addScreenButton];

    [theWindow orderFront:self];
}



- (void)addNewScreen
{
  var newItem = "New Item";
  content.push(newItem);
  [textCollectionView reloadContent];

  var indexOfNewItem = [content count] - 1,
    newRepresentedItem = [[[textCollectionView items][indexOfNewItem] view] text];

  // BUG REPORT -
  // The code below mostly works, though it does not automatically scroll the scroll view to the 
  // focused item.  It also does not actually put focus on the text field.
  //
  //[[newRepresentedItem window] makeFirstResponder:newRepresentedItem];
  //[newRepresentedItem setEditable:YES];

  // The code below this explanation does not work.  
  // In Firefox, it starts clipping all the previous entries (So, first, Item 1, disappears).
  // Furthermore, if this is run even once in Firefox, I can't get it back to normal 
  // (commenting out this code and reloading with the above code doesn't change the behavior).
  // Attempting to clear cookies after running the code below gives the following error in
  // Firefox:
  // key is null
  //   [Break on this error] return key.replace("-", "+").replace("_", "/");
  
  // In Safari, it moves the scroll view to focus on newRepresentedItem, but the scrollbar
  // appears incorrectly scrolled to the top, even though we are at the bottom of the list
  [newRepresentedItem setEditable:YES];
  [[newRepresentedItem window] makeFirstResponder:newRepresentedItem];
}

@end

@implementation TextIconView : CPView
{
  CPTextField text @accessors;
}

- (void)setSelected:(BOOL)isSelected
{ 
  [self setBackgroundColor:isSelected ? [CPColor grayColor] : nil];
}

- (void)setRepresentedObject:(id)anObject
{
  if (!text) {
      text = [[CPTextField alloc] initWithFrame:CGRectInset([self bounds], 10.0, 2.0)];
      [text setTextColor:[CPColor blackColor]];
      [text setFont:[CPFont fontWithName:"Helvetica" size:14.0]];
      [text setDrawsBackground:NO];
      [self addSubview:text];
  }

  [text setStringValue:anObject];      
  [text sizeToFit];
}
@end
