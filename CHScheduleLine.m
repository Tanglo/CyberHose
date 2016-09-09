/*
 * CHScheduleLine.m
 *
 * Created by: Lee Walsh on 13/08/2016.
 * Copyright (c) 2016 Lee David Walsh. All rights reserved.
 * This software is licensed under The MIT License (MIT)
 * See: https://github.com/Tanglo/CyberHose/blob/master/LICENSE.md
 */

#import "CHScheduleLine.h"

@implementation CHScheduleLine

-(id)init{
	NSLog(@"Error: use initWithStrings: instead of init");
	return nil;
}

-(CHScheduleLine *)initWithStrings: (NSArray *)strings AndHeaders: (NSArray *)headers{
	self = [super init];
	if (self) {
		
		return self;
	}
	return nil;
}

+(CHScheduleLine *)scheduleLineWithStrings: (NSArray *)strings AndHeaders: (NSArray *)headers{
	return [[[CHScheduleLine alloc] initWithStrings: strings AndHeaders: headers] autorelease];
}

-(void)printScheduleLine{
	
}

@end
