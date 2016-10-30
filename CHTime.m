/*
 * CHTime.m
 *
 * Created by: Lee Walsh on 01/10/2016.
 * Copyright (c) 2016 Lee David Walsh. All rights reserved.
 * This software is licensed under The MIT License (MIT)
 * See: https://github.com/Tanglo/CyberHose/blob/master/LICENSE.md
 */

#import "CHTime.h"

@implementation CHTime

-(id)init{
	NSLog(@"Error: use initWithInteger: instead of init");
	return nil;
}

-(CHTime *)initWithInteger: (NSInteger)newTime{
	self = [super init];
	if (self) {
		if((newTime >=0) && (newTime <= 2359)){
			_theTime = newTime;
		}
		return self;
	}
	return nil;
}

+(CHTime *)timeWithInteger: (NSInteger)newTime{
	return [[[CHTime alloc] initWithInteger: newTime] autorelease];
}

-(NSString*)description{
	NSString *timeString = [NSString stringWithFormat: @"%d", _theTime];
	if(_theTime < 1000){
		timeString = [@"0" stringByAppendingString: timeString];
	}
	timeString = [timeString stringByAppendingString: @"h"];
	return timeString;
}

-(NSInteger)hour{
//	NSLog([NSString stringWithFormat: @"The time is: %d", _theTime]);
//	NSLog([NSString stringWithFormat: @"The hours are: %d", _theTime/100]);
	return _theTime/100;
}

-(NSInteger)minute{
//	NSLog([NSString stringWithFormat: @"The time is: %d", _theTime]);
//	NSLog([NSString stringWithFormat: @"The minutes are: %d", _theTime -_theTime/100 *100]);
	return _theTime -_theTime/100 *100;
}

@end
