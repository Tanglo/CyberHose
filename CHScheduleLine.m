/*
 * CHScheduleLine.m
 *
 * Created by: Lee Walsh on 13/08/2016.
 * Copyright (c) 2016 Lee David Walsh. All rights reserved.
 * This software is licensed under The MIT License (MIT)
 * See: https://github.com/Tanglo/CyberHose/blob/master/LICENSE.md
 */

#import "CHScheduleLine.h"
#import "CHTime.h"
#import <syslog.h>

@implementation CHScheduleLine

-(id)init{
	NSLog(@"Error: use initWithStrings: instead of init");
	return nil;
}

-(CHScheduleLine *)initWithStrings: (NSArray *)strings AndHeaders: (NSArray *)headers{
	self = [super init];
	if (self) {
		//days and frequency
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
		
		//duration
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
		
		//times
		index = [headers indexOfObject: @"time"];
		NSArray *timeStrings = [[strings objectAtIndex: index] componentsSeparatedByString: @","];
		NSMutableArray *newTimes = [NSMutableArray array];
		for(NSString *currTimeString in timeStrings){
			lineScanner = [NSScanner scannerWithString: currTimeString];
			NSInteger newTimeInt = 0;
			if([lineScanner scanInteger: &newTimeInt]){
				CHTime *newTime = [CHTime timeWithInteger: newTimeInt];
				if(newTime != nil){
					[newTimes addObject: newTime];
				}	
			}
		}
		_times = newTimes;
		
		//sources
		NSMutableArray* newWaterSources = [NSMutableArray array];
		BOOL sourceWasFound;
		NSString* currSource = nil;
		NSInteger sourceCount = 0;
		do{
			sourceWasFound = NO;
			currSource = [NSString stringWithFormat: @"s%d", sourceCount];
			if((index = [headers indexOfObject: currSource]) != NSNotFound){
				lineScanner = [NSScanner scannerWithString: [strings objectAtIndex: index]];
				NSInteger newSourceValue;
				NSNumber *newSourceNumberValue = [NSNumber numberWithBool: NO];
				if([lineScanner scanInteger: &newSourceValue]){
					if(newSourceValue){
						newSourceNumberValue = [NSNumber numberWithBool: YES];
					}
				}
				sourceWasFound = YES;
				sourceCount++;
				[newWaterSources addObject: newSourceNumberValue];
//				NSLog([NSString stringWithFormat: @"%@ - %d, %d", currSource, index, newSourceValue]);
			}
		}while(sourceWasFound);
		_waterSources = [NSArray arrayWithArray: newWaterSources];
		
		return self;
	}
	return nil;
}

+(CHScheduleLine *)scheduleLineWithStrings: (NSArray *)strings AndHeaders: (NSArray *)headers{
	return [[[CHScheduleLine alloc] initWithStrings: strings AndHeaders: headers] autorelease];
}

-(void)startIrrigation{
	
}

-(void)stopIrrigation{
	
}


-(void)printScheduleLine{
	NSString *waterSourcesString = @"";
	for(NSNumber *currSource in _waterSources){
		waterSourcesString = [waterSourcesString stringByAppendingString: [NSString stringWithFormat: @"%s ", [currSource boolValue] ? "YES" : "NO"]];
	}
	NSLog([NSString stringWithFormat: @"freq: %d; dur: %d; days: %@; times: %@, sources: %@", _frequency, _duration, _days, _times, waterSourcesString]);
}

@end
