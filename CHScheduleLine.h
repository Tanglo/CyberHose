/*
 * CHScheduleLine.h
 *
 * Created by: Lee Walsh on 09/09/2016.
 * Copyright (c) 2016 Lee David Walsh. All rights reserved.
 * This software is licensed under The MIT License (MIT)
 * See: https://github.com/Tanglo/CyberHose/blob/master/LICENSE.md
 */

#import <Foundation/Foundation.h>

/*!
 @brief A class to manage a single line of a CyberHose schedule.
 
 Instances of this class are expected to be allocated and initialised when a CHScehdule is initialised.  They are not mutable.
 */
@interface CHScheduleLine : NSObject {
	
	/// @brief The frequency of irrigation in hours.  Ignored if days in non-zero.
	NSInteger freq;
	
	/// @brief The duration of irrigation in minutes
	NSInteger duration;
	
	/// @brief The coded days sum of the days to water.  Sun=1, Mon=2, Tue=4, Wed=8, Thu=16, Fri=32, Sat=64
	NSInteger days;
	
	/// @brief An array of @c BOOL wrapped in @c NSNumber objects.  These indicate which water sources can be used for this line.
	NSArray *waterSources;
		
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

/*! A debugging function that prints the scheduleLine using NSLog
 */
-(void)printScheduleLine;

@end
