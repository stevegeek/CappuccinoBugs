/*
 * AppController.j
 * #48
 *
 */

@import <Foundation/CPObject.j>
@import <AppKit/CPToolbar.j>


var ButtonToolbarItemIdentifier = @"ButtonToolbarItemIdentifier";


/* Issue 48:
   http://github.com/280north/cappuccino/issues#issue/48
   CPToolbar setEnabled:
   
   Test submitted by BlairDuncan
   
   "calling setEnabled:NO appears to have no effect on the CPToolbarItem. It 
   should cause the toolbar item to be rendered as disabled (or semi-opaque) and
   should prevent the toolbar item’s selector from being called."
 */

@implementation AppController : CPObject
{
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask] 
        contentView = [theWindow contentView];

    [theWindow orderFront:self];

    var toolbar = [[CPToolbar alloc] initWithIdentifier:@"MyToolbar"]; 
    [toolbar setDelegate:self]; 
    [theWindow setToolbar:toolbar]; 
}

- (CPArray)toolbarAllowedItemIdentifiers:(CPToolbar)aToolbar
{ return [ButtonToolbarItemIdentifier]; }

- (CPArray)toolbarDefaultItemIdentifiers:(CPToolbar)aToolbar
{ return [ButtonToolbarItemIdentifier]; }

- (CPToolbarItem)toolbar:(CPToolbar)aToolbar itemForItemIdentifier:(CPString)anItemIdentifier willBeInsertedIntoToolbar:(BOOL)isBeingInsertedIntoToolbar 
{ 
    if(isBeingInsertedIntoToolbar)
    {
        var toolbarItem = [[CPToolbarItem alloc] initWithItemIdentifier:anItemIdentifier];

        [toolbarItem setTarget:self];
        [toolbarItem setMinSize:CGSizeMake(32.0, 32.0)];
        [toolbarItem setMaxSize:CGSizeMake(32.0, 32.0)];
        switch(anItemIdentifier)
        {
            case ButtonToolbarItemIdentifier:
            var image = [[CPImage alloc] initWithContentsOfFile:@"Frameworks/AppKit/Resources/CPApplication/New.png" size:CGSizeMake(32.0, 32.0)],
                alternateImage = [[CPImage alloc] initWithContentsOfFile:@"Resources/spinner.gif" size:CGSizeMake(32.0, 32.0)];
            [toolbarItem setLabel:@"bling bling"];
            [toolbarItem setImage:image];
            [toolbarItem setAlternateImage:alternateImage];
            [toolbarItem setTarget:self];
            [toolbarItem setAction:@selector(doButton:)];
            [toolbarItem setEnabled:NO];
            break;
        }
    } else {
        var toolbarItemIndex = [aToolbar._itemIdentifiers indexOfObject:anItemIdentifier];
        var toolbarItems = [aToolbar items];
        var toolbarItem = toolbarItems[toolbarItemIndex];
    }
    return toolbarItem;
}

@end
