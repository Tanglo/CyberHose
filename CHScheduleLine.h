/*
 * CHScheduleLine.h
 *
 * Created by: Lee Walsh on 09/09/2016.
 * Copyright (c) 2016 Lee David Walsh. All rights reserved.
 * This software is licensed under The MIT License (MIT)
 * See: https://github.com/Tanglo/CyberHose/blob/master/LICENSE.md
 */

#import <Foundation/Foundation.h>

#define CHSunday @"CHStringSunday"
#define CHMonday @"CHStringMonday"
#define CHTuesday @"CHStringTuesday"
#define CHWednesday @"CHStringWednesday"
#define CHThursday @"CHStringThursday"
#define CHFriday @"CHStringFriday"
#define CHSaturday @"CHStringSaturday" 

/*!
 @brief A class to manage a single line of a CyberHose schedule.
 
 Instances of this class are expected to be allocated and initialised when a CHScehdule is initialised.  They are not mutable.
 */
@interface CHScheduleLine : NSObject {
	
	/// @brief The frequency of irrigation in hours.  Ignored if days in non-zero.
	NSInteger _frequency;
	
	/// @brief The duration of irrigation in minutes
	NSInteger _duration;
	
	/// @brief An array of @c NSString objects coding days to water on.  Possible objects are @c CHSunday, @c CHMonday, @c CHTuesday, @c CHWednesday, @c CHThursday, @c CHFriday, or @c CHSaturday.
	NSArray *_days;
	
	/// @brief An array of @c CHTime objects that represent the starting times from the cyberhoseSchedule.
	NSArray *_times;
	
	/// @brief An array of @c BOOL wrapped in @c NSNumber objects.  These indicate which water sources can be used for this line.
	NSArray *_waterSources;
		
}

/*! Initialises a @c CHScheduleLine object using the array of strings and array of headers that are provided.  The header array is used to determine the position of each field in the line, that is if "freq" is at index 2 in the header array, the value at index 2 in the line strings array will be used to initialise the freq variable of the CHScheduleLine.
 * @param strings An @c NSArray of strings to that are used to initialise the instance of @c CHScheduleLine.
 * @param headers An @c NSArray of strings containing the header strings.
 * @return If sucessful, an initialised instance of @c CHSchedule, otherwise @c nil.
 */
-(CHScheduleLine *)initWithStrings: (NSArray *)strings AndHeaders: (NSArray *)headers;

/*! Create and initialises a new instance of @c CHScheduleLine using the array of strings and array of headers that are provided.  The header array is used to determine the position of each field in the line, that is if "freq" is at index 2 in the header array, the value at index 2 in the line strings array will be used to initialise the freq variable of the CHScheduleLine.
 * @param strings An @c NSArray of strings to that are used to initialise the instance of @c CHScheduleLine.
 * @param headers An @c NSArray of strings containing the header strings.
 * @return If sucessful, an initialised instance of @c CHSchedule, otherwise @c nil.
 */
+(CHScheduleLine *)scheduleLineWithStrings: (NSArray *)strings AndHeaders: (NSArray *)headers;

/*! This method is called by instances of @c NSTImer when they fire.  It starts irrigation of this line and then sets and @c NSTimer object to signal the end of irrigation.
 */
-(void)startIrrigation;

/*! This method is called by instances of @c NSTImer when they fire.  It stops irrigation of this line and then sets and @c NSTimer object to signal the next schedule start for this line.
 */
-(void)stopIrrigation;


/*! A debugging function that prints the scheduleLine using NSLog
 */
-(void)printScheduleLine;

@end
