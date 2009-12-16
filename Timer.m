//
//  Timer.m
//
//  Created by Jeena on 15.12.09.
//  Copyright 2009 Jeena Paradies. All rights reserved.
//	sound from http://www.flashkit.com/soundfx/Electronic/Alarms/Alarm_cl-Liquid-8852/index.php
//	click sound from http://free-loops.com/download-free-loop-7744.html
//

#import "Timer.h"

@implementation Timer

@synthesize repeatingTimer;

- (id)init {
	
	if (self = [super init]) {
		
		digits = [[NSMutableArray alloc] init];
		for(int i = 0; i <= 9; i++) {
			[digits addObject:[NSImage imageNamed:[NSString stringWithFormat:@"digit-%i.png", i]]];
		}

		colon = [[NSImage imageNamed:@"colon.png"] retain];
		no_colon = [[NSImage imageNamed:@"no_colon.png"] retain];
		start_button = [[NSImage imageNamed:@"start-button.png"] retain];
		pause_button = [[NSImage imageNamed:@"pause-button.png"] retain];
		alarm_button = [[NSImage imageNamed:@"alarm-button.png"] retain];
		
		NSString *path = [[NSBundle mainBundle] pathForResource:@"alarm" ofType:@"wav"];
		alarmSound = [[NSSound alloc] initWithContentsOfFile:path byReference:NO];
		[path release];
		[alarmSound setLoops:YES];
		[alarmSound setVolume:1];
		
		path = [[NSBundle mainBundle] pathForResource:@"click" ofType:@"wav"];
		clickSound = [[NSSound alloc] initWithContentsOfFile:path byReference:NO];
		[path release];
		[clickSound setLoops:NO];
		[clickSound setVolume:0.2];
		
		path = [[NSBundle mainBundle] pathForResource:@"clear" ofType:@"wav"];
		clearSound = [[NSSound alloc] initWithContentsOfFile:path byReference:NO];
		[path release];
		[clearSound setLoops:NO];
		[clearSound setVolume:0.2];
		
		remainingSeconds = 0;
		isAlarm = NO;
		cleared = NO;
		ongoing = NO;
	}
	
	return self;
}

- (void)applicationLoaded:(id)sender {
	[(NSButtonCell *)[hour1 cell] setHighlightsBy:NSContentsCellMask];
	[(NSButtonCell *)[hour2 cell] setHighlightsBy:NSContentsCellMask];
	[(NSButtonCell *)[minute1 cell] setHighlightsBy:NSContentsCellMask];
	[(NSButtonCell *)[minute2 cell] setHighlightsBy:NSContentsCellMask];
	[(NSButtonCell *)[second1 cell] setHighlightsBy:NSContentsCellMask];
	[(NSButtonCell *)[second2 cell] setHighlightsBy:NSContentsCellMask];
	[(NSButtonCell *)[start cell] setHighlightsBy:NSContentsCellMask];
	[(NSButtonCell *)[clear cell] setHighlightsBy:NSContentsCellMask];
	[self clearNow];
}


- (IBAction)startOrPause:(NSButton *)sender {
	
	[clickSound play];
	ongoing = YES;
	
	if (isAlarm) {
		cleared = YES;
		start.image = start_button;
		[self clearNow];
	
	} else {

		if (start.image == start_button) {
			start.image = pause_button;
			[self startRepeatingTimer:self];
			[clear setTransparent:YES];
			cleared = NO;
			
		} else if (start.image == pause_button) {
			
			start.image = start_button;
			[self stopRepeatingTimer:self];
			[clear setTransparent:NO];
			
		}
		
	}

}

- (void)clearNow:(id)sender {
	[self clearNow];
	[clear setTransparent:YES];
	[clearSound play];
}

- (void)clearNow {
	
	remainingSeconds = [[NSUserDefaults standardUserDefaults] integerForKey:@"defaultTime"];

	[self setDigitsForTime:remainingSeconds];
	ongoing = NO;
}


- (void)tick:(NSTimer*)theTimer {

	[self setDigitsForTime:remainingSeconds];

	remainingSeconds -= 1;
	if (remainingSeconds < 0) {
		[theTimer invalidate];
		self.repeatingTimer = nil;
		start.image = alarm_button;
		[self alarm:self];
		cleared = NO;
	}
}

- (void)setDigitsForTime:(int)time {
	
	int hd2, hd1, md2, md1, sd2, sd1, hours, minutes, seconds;
	
	hours = time / 3600;
	hd1 = hours % 10;
	hd2 = (hours - hd1) / 10;
	
	minutes = (time - (hours * 3600)) / 60;
	md1 = minutes % 10;
	md2 = (minutes - md1) / 10;
	
	seconds = time - (hours * 3600) - (minutes * 60);
	sd1 = seconds % 10;
	sd2 = (seconds - sd1) / 10;
	
	hour2.image = [digits objectAtIndex:hd2];
	hour1.image = [digits objectAtIndex:hd1];
	minute2.image = [digits objectAtIndex:md2];
	minute1.image = [digits objectAtIndex:md1];
	second2.image = [digits objectAtIndex:sd2];
	second1.image = [digits objectAtIndex:sd1];
	
}

- (void)alarm:(id)sender {

	isAlarm = YES;
	
	if (cleared == NO) {
		[alarmSound play];
		[self performSelector:@selector(alarm:) withObject:self afterDelay:1];
	} else {
		[alarmSound stop];
		isAlarm = NO;
	}

}

- (IBAction)startRepeatingTimer:(id)sender {
	
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1
													  target:self selector:@selector(tick:)
													userInfo:nil repeats:YES];
    self.repeatingTimer = timer;
}

- (IBAction)stopRepeatingTimer:(id)sender {
    [repeatingTimer invalidate];
    self.repeatingTimer = nil;
}

- (IBAction)changeDigit:(NSButton *)sender {

	if (repeatingTimer == nil) {
		
		[clickSound play];

		int time = remainingSeconds;
		
		int hd2, hd1, md2, md1, sd2, sd1, hours, minutes, seconds;
		
		hours = time / 3600;
		hd1 = hours % 10;
		hd2 = (hours - hd1) / 10;
		
		minutes = (time - (hours * 3600)) / 60;
		md1 = minutes % 10;
		md2 = (minutes - md1) / 10;
		
		seconds = time - (hours * 3600) - (minutes * 60);
		sd1 = seconds % 10;
		sd2 = (seconds - sd1) / 10;
		
		if (sender == hour2) {
			hd2 = (hd2 + 1) % 10;
		} else if (sender == hour1) {
			hd1 = (hd1 + 1) % 10;
		} else if (sender == minute2) {
			md2 = (md2 + 1) % 6;
		} else if (sender == minute1) {
			md1 = (md1 + 1) % 10;
		} else if (sender == second2) {
			sd2 = (sd2 + 1) % 6;
		} else if (sender == second1) {
			sd1 = (sd1 + 1) % 10;
		}
		
		remainingSeconds = hd2 * 3600 * 10 + hd1 * 3600 + md2 * 60 * 10 + md1 * 60 + sd2 * 10 + sd1;
		
		[[NSUserDefaults standardUserDefaults] setInteger:remainingSeconds forKey:@"defaultTime"];
		[self clearNow];
	}
	
}

@end
