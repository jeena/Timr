//
//  TimrAppDelegate.h
//  Timr
//
//  Created by Jeena on 15.12.09.
//  Copyright 2009 Jeena Paradies. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Timer.h"

#if (MAC_OS_X_VERSION_MAX_ALLOWED <= MAC_OS_X_VERSION_10_5)
@interface TimrAppDelegate : NSObject
#else
@interface TimrAppDelegate : NSObject <NSApplicationDelegate>
#endif
{
	IBOutlet NSWindow *window;
	IBOutlet Timer *timer;
	IBOutlet NSWindow *aWindow;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet Timer *timer;
@property (assign) IBOutlet NSWindow *aWindow;

@end
