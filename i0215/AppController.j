/*
 * AppController.j
 * i0215
 *
 * Created by You on October 16, 2009.
 * Copyright 2009, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>

/*
http://github.com/280north/cappuccino/issues/#issue/215

nib2cib doesn't honor trackingMode for CPSegmentedControl

Although nib2cib mentions trackingMode several times in the source, it doesn't 
properly translate the value when making a cib. It appears to set it to null.

*/

@implementation AppController : CPObject
{
    CPWindow    theWindow; //this "outlet" is connected automatically by the Cib
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    // This is called when the application is done loading.
}

- (void)awakeFromCib
{
    // This is called when the cib is done loading.
    // You can implement this method on any object instantiated from a Cib.
    // It's a useful hook for setting up current UI values, and other things. 
    
    // In this case, we want the window from Cib to become our full browser window
    [theWindow setFullBridge:YES];
}

@end
