//
//  TimrAppDelegate.m
//  Timr
//
//  Created by Jeena on 15.12.09.
//  Copyright 2009 Jeena Paradies. All rights reserved.
//

#import "TimrAppDelegate.h"

@implementation TimrAppDelegate

@synthesize window, timer;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	
	[timer applicationLoaded:self];
}


@end
