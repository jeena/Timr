//
//  Timer.h
//
//  Created by Jeena on 15.12.09.
//  Copyright 2009 Jeena Paradies. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Timer : NSObject {
	
    IBOutlet NSButton *hour1;
    IBOutlet NSButton *hour2;
    IBOutlet NSButton *minute1;
    IBOutlet NSButton *minute2;
    IBOutlet NSButton *second1;
    IBOutlet NSButton *second2;
    IBOutlet NSButton *start;
	IBOutlet NSButton *clear;

	NSMutableArray *digits;
	NSImage *colon;
	NSImage *no_colon;
	NSSound *alarmSound;
	NSSound *clickSound;
	NSSound *clearSound;
	
	int remainingSeconds;
	bool pause;
	bool isAlarm;
	bool cleared;
	bool ongoing;
	
	NSTimer *repeatingTimer;
    id<NSObject> action;
}

@property (assign) NSTimer *repeatingTimer;

- (id)init;
- (void)applicationLoaded:(id)sender;
- (void)alarm:(id)sender;
- (void)setDigitsForTime:(int)time;
- (void)clearNow;

- (IBAction)startOrPause:(NSButton *)sender;
- (IBAction)changeDigit:(NSButton *)sender;
- (IBAction)clearNow:(id)sender;

- (void)startRepeatingTimer:(id)sender;
- (void)stopRepeatingTimer:(id)sender;

@end
