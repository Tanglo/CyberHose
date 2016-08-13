/*
 * CHSchedule.m
 *
 * Created by: Lee Walsh on 13/08/2016.
 * Copyright (c) 2016 Lee David Walsh. All rights reserved.
 * This software is licensed under The MIT License (MIT)
 * See: https://github.com/Tanglo/CyberHose/blob/master/LICENSE.md
 */

#import "CHSchedule.h"

@implementation CHSchedule

-(id)init{
	NSLog(@"Error: use initWithPath: instead of init");
	return nil;
}

-(id)initWithPath: (NSString *)path{
	self = [super init];
	if (self) {
		NSString *fullPath = [path stringByExpandingTildeInPath];
		if([[NSFileManager defaultManager] fileExistsAtPath: fullPath]){
			NSLog([NSString stringWithFormat: @"Found schedule file at %@", fullPath]);
			NSError *error;
			NSString *scheduleString = [NSString stringWithContentsOfFile: fullPath encoding: NSUTF8StringEncoding error: &error];
			if(fullPath != nil){
				NSLog(scheduleString);
			}
		return self;
		}
	}
	return nil;
}

+(CHSchedule *)scheduleWithPath: (NSString *) path{
	return [[[CHSchedule alloc] initWithPath: path] autorelease];
}

@end
