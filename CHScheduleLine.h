/*
 * CHScheduleLine.h
 *
 * Created by: Lee Walsh on 09/09/2016.
 * Copyright (c) 2016 Lee David Walsh. All rights reserved.
 * This software is licensed under The MIT License (MIT)
 * See: https://github.com/Tanglo/CyberHose/blob/master/LICENSE.md
 */

#import <Foundation/Foundation.h>

/*
#define CHSunday @"CHStringSunday"
#define CHMonday @"CHStringMonday"
#define CHTuesday @"CHStringTuesday"
#define CHWednesday @"CHStringWednesday"
#define CHThursday @"CHStringThursday"
#define CHFriday @"CHStringFriday"
#define CHSaturday @"CHStringSaturday" 
*/

extern NSString *const CHSunday;
extern NSString *const CHMonday;
extern NSString *const CHTuesday;
extern NSString *const CHWednesday;
extern NSString *const CHThursday;
extern NSString *const CHFriday;
extern NSString *const CHSaturday;


@class CHTime;

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

/*! This method starts irrigation of this line.
 */
-(void)startIrrigation;

/*! This method stops irrigation of this line.
 */
-(void)stopIrrigation;

/*! Gets the next time that irrigation of this line should be started if it stops at the specified triggerTime
 * @param startTime The last time that that irrigation of this line was started.  If @c startTime is set to @c nil and this line uses frequency (rather than days), the startTime will be within 24 h.
 * @return A triggerTime for starting irrigation of this line.
 */
-(NSDate *)nextStartTimeWith: (NSDate *)lastStartTime;

/*! Gets the time that irrigation of this line should be stopped if it starts at the specified triggerTime
 * @param lastStartTime The time that irrigation of this line was/will be started.
 * @return A triggerTime for stopping irrigation of this line.
 */
-(NSDate*)stopTimeWith: (NSDate *)startTime;

/*! Returns a new instance of @c NSDate which has the same calendar day day as a specified date and the time of specified @c CHTime object.
 * @param date The date used to source the calendar day.
 * @param time The four digit time used to source the time.
 * @return An @c NSDate composed from the calendar Year, month, an day of @c date and the hours and minutes of @c time.
 */
+(NSDate*)dateBySettingTimeOf: (NSDate*)date To: (CHTime*)time;

/*! Returns a new instance of @c NSDate which is the same as the specified @c date moved forward to the specified @c time on the next specified @c day (i.e. Monday, Tuesday, etc.).  For example, if @c date is 04 Dec 2016, @c day is @c CHWednesday, and @c time is and @c CHTime object that sepcified 1900 h, the this method will return and @c NSDate equal to 07 Dec 2016, 1900 h.
 * @param date The base date that will be moved forward.
 * @param day The day that the new date will have.  THis needs to be from those defined in @c CHSheduleLine (e.g. CHMonday).
 * @param time The four digit time that the new date will have.
 * @return An @c NSDate composed by moving @c date forward to @c time on the next @c day.
 */
+(NSDate*)dateByAdvancing: (NSDate*)date ToDay: (NSString*)day AndTime: (CHTime*)time;

/*! Returns the next day and time (from now) from the combination of the array @c CHWeekday constandts and @c CHTime objects.  For example, if @c days == [CHMonday; CHFriday] and @c times == [0700; 1900], and it is currently 04 Dec 2016, 1300, then this method will return CHMonday, 0700.  If the same data were provided but it was 05 Dec 2016, 1300 h, this method will return CHMonday 1900 h.
 * @param days An @c NSArray of @c CHWeekday constants (e.g. CHFriday)
 * @param times An@c NSArray of @c CHTime objects.
 * @return The next day and time combination going forward from the date and time that the method was called.
 */
+(NSDictionary*)nextDayAndTimeFromDays: (NSArray*)days AndTimes: (NSArray*)times;

@end
