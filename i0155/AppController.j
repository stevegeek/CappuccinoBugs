/*
 * AppController.j
 * CPScrollViewBug
 *
 * Created by You on May 27, 2009.
 * Copyright 2009, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>
@import <AppKit/CPScrollView.j>


/*
http://github.com/280north/cappuccino/issues#issue/155
Test by: saikat

see comments below
*/

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

    [contentView addSubview:textCollectionView];

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
  // BUG REPORT
  // Using Safari 3 and Firefox 3
  // The following works on both Safari and Firefox to select the first item in the collection
  // view (though it does not, of course, display the newly added item
  // var indexOfNewItem = [content count] - 1,
  //   newRepresentedItem = [[[textCollectionView items][0] view] text];

  // [newRepresentedItem setEditable:YES];
  // [[newRepresentedItem window] makeFirstResponder:newRepresentedItem];
  // [newRepresentedItem selectText:self];

  // The following works in Safari to select the first item in the collection while
  // also adding the new item in the collection.  In Firefox it does not even select
  // the first item in the collection
//   [textCollectionView reloadContent];
//   var indexOfNewItem = [content count] - 1,
//     newRepresentedItem = [[[textCollectionView items][0] view] text];

//   [newRepresentedItem setEditable:YES];
//   [[newRepresentedItem window] makeFirstResponder:newRepresentedItem];
//   [newRepresentedItem selectText:self];

  // The following does not work in Safari or Firefox - nothing gets selected
  [textCollectionView reloadContent];
  var indexOfNewItem = [content count] - 1,
    newRepresentedItem = [[[textCollectionView items][indexOfNewItem] view] text];

  [newRepresentedItem setEditable:YES];
  [[newRepresentedItem window] makeFirstResponder:newRepresentedItem];
  [newRepresentedItem selectText:self];

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
