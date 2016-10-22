/*
 * CHEvent.m
 *
 * Created by: Lee Walsh on 22/10/2016.
 * Copyright (c) 2016 Lee David Walsh. All rights reserved.
 * This software is licensed under The MIT License (MIT)
 * See: https://github.com/Tanglo/CyberHose/blob/master/LICENSE.md
 */

#import "CHEvent.h"

@implementation CHEvent

-(id)init{
	NSLog(@"Error: use initWithTriggerTime:Line:AndAction: instead of init");
	return nil;
}

-(CHEvent *)initWithTriggerTime: (NSDate *)triggerTime Line: (CHScheduleLine *)line AndAction: (NSString *)action{
	self = [super init];
	if (self) {
		_triggerTime = triggerTime;
		_line = line;
		_action = action;
		return self;
	}
	return nil;
}

+(CHEvent *)eventWithTriggerTime: (NSDate *)triggerTime Line: (CHScheduleLine *)line AndAction: (NSString *)action{
	return [[[CHEvent alloc] initWithTriggerTime: triggerTime Line: line AndAction: action] autorelease];
}

-(NSDate *)triggerTime{
	return _triggerTime;
}

-(CHScheduleLine *)line{
	return _line;
}

-(NSString *)action{
	return _action;
}

@end
