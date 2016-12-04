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

NSString *const CHSunday = @"CHStringSunday";
NSString *const CHMonday = @"CHStringMonday";
NSString *const CHTuesday = @"CHStringTuesday";
NSString *const CHWednesday = @"CHStringWednesday";
NSString *const CHThursday = @"CHStringThursday";
NSString *const CHFriday = @"CHStringFriday";
NSString *const CHSaturday = @"CHStringSaturday";

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

-(NSDate *)nextStartTimeWith: (NSDate *)lastStartTime{
//	NSLog([NSString stringWithFormat: @"lastStartTime: %@", lastStartTime]);
	if(_days == nil){
		//use frequency method
		NSDate* newTriggerTime = nil;
		if(lastStartTime){
			newTriggerTime = [lastStartTime dateByAddingTimeInterval: _frequency*60*60];
		} else {
			newTriggerTime = [NSDate date];
		}
		return [CHScheduleLine dateBySettingTimeOf: newTriggerTime To: [_times objectAtIndex:0]];
	} else {
		//use days method
		NSDate* previousDate = [NSDate date];
		if(lastStartTime){
			previousDate = lastStartTime;
		}
		NSDictionary* nextDayAndTime = [CHScheduleLine nextDayAndTimeFromDays: _days AndTimes: _times];
		
		return [CHScheduleLine dateByAdvancing: previousDate ToDay: CHWednesday AndTime: [_times objectAtIndex:0]];
	}
	return nil;
}

-(NSDate*)stopTimeWith: (NSDate *)startTime{

	return nil;
}

+(NSDate*)dateBySettingTimeOf: (NSDate*)date To: (CHTime*)time{
	NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
	NSDateComponents *components = [gregorianCalendar components: NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate: date];
	[components setHour: [time hour]];
	[components setMinute: [time minute]];
	return [gregorianCalendar dateFromComponents: components];
}

+(NSDate*)dateByAdvancing: (NSDate*)date ToDay: (NSString*)day AndTime: (CHTime*)time{
	NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
	NSDateComponents *components = [gregorianCalendar components: NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSWeekdayCalendarUnit fromDate: date];
	NSInteger weekdayInt = -1;
	if([day isEqualTo: CHSunday]){
		weekdayInt = 1;
	} else if([day isEqualTo:CHMonday]){
		weekdayInt = 2;
	} else if([day isEqualTo:CHTuesday]){
		weekdayInt = 3;
	} else if([day isEqualTo:CHWednesday]){
		weekdayInt = 4;
	} else if([day isEqualTo:CHThursday]){
		weekdayInt = 5;
	} else if([day isEqualTo:CHFriday]){
		weekdayInt = 6;
	} else if([day isEqualTo:CHSaturday]){
		weekdayInt = 7;
	}
	NSInteger numOfDaysToAdvance = weekdayInt - [components weekday];
	if(numOfDaysToAdvance == 0){
		numOfDaysToAdvance = 7;
	}
	[components setDay: [components day] + numOfDaysToAdvance];
	[components setHour: [time hour]];
	[components setMinute: [time minute]];
	
	return [gregorianCalendar dateFromComponents: components];;

}

+(NSDictionary*)nextDayAndTimeFromDays: (NSArray*)days AndTimes: (NSArray*)times{

	return nil;
}


-(NSString*)description{
	NSString *waterSourcesString = @"";
	for(NSNumber *currSource in _waterSources){
		waterSourcesString = [waterSourcesString stringByAppendingString: [NSString stringWithFormat: @"%s ", [currSource boolValue] ? "YES" : "NO"]];
	}
	return [NSString stringWithFormat: @"freq: %d; dur: %d; days: %@; times: %@, sources: %@", _frequency, _duration, _days, _times, waterSourcesString];
}

@end
