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
		NSInteger index = [headers indexOfObject: @"days"];
		NSScanner *lineScanner = [NSScanner scannerWithString: [strings objectAtIndex: index]];
		NSInteger days;
		if([lineScanner scanInteger: &days]){
			_frequency = -1;
			NSMutableArray *newDays = [NSMutableArray array];
			if((days-64) >= 0){
				[newDays addObject: CHSaturday];
				days -= 64;
			}
			if((days-32) >= 0){
				[newDays addObject: CHFriday];
				days -= 32;
			}
			if((days-16) >= 0){
				[newDays addObject: CHThursday];
				days -= 16;
			}
			if((days-8) >= 0){
				[newDays addObject: CHWednesday];
				days -= 8;
			}
			if((days-4) >= 0){
				[newDays addObject: CHTuesday];
				days -= 4;
			}
			if((days-2) >= 0){
				[newDays addObject: CHMonday];
				days -= 2;
			}
			if(days > 0){
				[newDays addObject: CHSunday];
			}
			_days = [NSArray arrayWithArray: newDays];
		} else {
		_days = nil;
			index = [headers indexOfObject: @"freq"];
			lineScanner = [NSScanner scannerWithString: [strings objectAtIndex: index]];
			if([lineScanner scanInteger: &_frequency]){
				if(![lineScanner isAtEnd]){
					NSString *freqUnit = [[strings objectAtIndex: index] substringFromIndex: [lineScanner scanLocation]];
					if([freqUnit isEqualTo: @"d"]){
						_frequency *= 24;
					} else if([freqUnit isEqualTo: @"w"]){
						_frequency *= 168;
					}
				}
			}
		}
		
		index = [headers indexOfObject: @"dur"];
		lineScanner = [NSScanner scannerWithString: [strings objectAtIndex: index]];
		if([lineScanner scanInteger: &_duration]){
			if(![lineScanner isAtEnd]){
				NSString *durUnit = [[strings objectAtIndex: index] substringFromIndex: [lineScanner scanLocation]];
				if([durUnit isEqualTo: @"h"]){
					_duration *= 60;
				}
			}
		} else {
			_duration = -1;
		}
		
		
		
		return self;
	}
	return nil;
}

+(CHScheduleLine *)scheduleLineWithStrings: (NSArray *)strings AndHeaders: (NSArray *)headers{
	return [[[CHScheduleLine alloc] initWithStrings: strings AndHeaders: headers] autorelease];
}

-(void)printScheduleLine{
	NSLog([NSString stringWithFormat: @"freq: %d; dur: %d; days: %@", _frequency, _duration, _days]);
}

@end
