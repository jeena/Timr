//
//  TimrAppDelegate.m
//  Timr
//
//  Created by Jeena on 15.12.09.
//  Copyright 2009 Jeena Paradies. All rights reserved.
//

#import "TimrAppDelegate.h"

@implementation TimrAppDelegate

@synthesize window, timer, aWindow;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	[aWindow setBackgroundColor:[NSColor colorWithPatternImage:[NSImage imageNamed:@"wood.png"]]];
	[timer applicationLoaded:self];
	
	[aWindow orderFront:self];
}


@end
