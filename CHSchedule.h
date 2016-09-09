/*
 * CHSchedule.h
 *
 * Created by: Lee Walsh on 13/08/2016.
 * Copyright (c) 2016 Lee David Walsh. All rights reserved.
 * This software is licensed under The MIT License (MIT)
 * See: https://github.com/Tanglo/CyberHose/blob/master/LICENSE.md
 */

#import <Foundation/Foundation.h>

/*!
 @brief A class to load and store the CyberHose schedule.
 
 An instance of this class is created when CyberHose starts.  The schedule is then loaded from the path specified in the settings file (~/.cyberhose).
 * 
 * The format for the schedule file is:

 * line      | freq | dur | days | s0(tank) | s1(mains) | s2(grey)
 * 0(fruit)  | 2w   | 1h  | -    | 1        | 1         | 1
 * 1(bonsai) | 1d   | 10m | -    | 1        | 1         | 0
 * 2(veges)  | -    | 30m | 84   | 1        | 1         | 1
 * 
 * The 'line' and 'dur' columns must be present.  At least one of the 'freq' or 'days' must be present. There must be at least one 'sX' column, but there can be as many as needed.  Text contained by brackets and white space are ignored.  Thus brackets can be used to make comments. The '|' characters are the separators for the variables.  A single '-' represents no entry.
 * 
 * Each of the columns has the following meaning:
 * line: the number of the irrigation line.  Each line represents a single entry in the schedule
 * 
 * freq: how often the line is irrigated.  'w' refers to weeks, 'd' to days, and 'h' to hours.  2w, means water every second week, 3d, means water every 3rd day, etc.
 * 
 * dur: the duration of the irrigation.  'h' means hours, and 'm' means minutes.  So entering 10m will run the irrigation on that line for 10 minutes.
 * 
 * days: rather than specifying a frequency, one can specify which days of the week to irrigate.  Here a binary sum flag is used where Sun=1, Mon=2, Tue=4, Wed=8, Thu=16, Fri=32, Sat=64.  For example to water on Tue, The and Sat, set days = 4+16+64 = 84 in the last two lines of the example above.  Specifying the days variable for a line will causes the freq variable to be ignored.
 * 
 * sX: Each of these represents a water source that is specified in the CyberHose settings.  There can be as many of these as needed, but they will be ignored if the matching settings are not found.  Lower numbered sources take priority.  So CyberHose will attempt to water with s0 first, and will only use s1 is s0 is unavailable, it will try s1 before s2, and so on.
 */
@interface CHSchedule : NSObject {
	
	/// @brief An array of the @c CHScheduleLine objects
	NSArray *scheduleLines;
}

/*! Initialises a @c CHSchedule object using the path provided.
 * @param path An @c NSString that conatins the path to the CyberHose schedule file that will be loaded.
 * @return If sucessful, an initialised instance of @c CHSchedule, otherwise @c nil.
 */
-(id)initWithPath: (NSString *)path;

/*! Creates and initialises an autoreleasing @c CHSchedule object using the path provided.
 * @param path An @c NSString that conatins the path to the CyberHose schedule file that will be loaded.
 * @return If sucessful, an initialised instance of @c CHSchedule, otherwise @c nil.
 */
+(CHSchedule *)scheduleWithPath: (NSString *) path;

/*! Removes the commented lines and blanks lines (i.e. "") from an array of schedule lines
 * @param lines An array of cyberhose schedule line strings.
 * @return and NSArray of cyberhose schedule strings with the blank and commented lines removed.
 */
+(NSArray *)scheduleLinesByRemovingCommentsAndBlankLinesFrom: (NSArray *)lines;

/*! Removeds the variable comments (i.e. text contained in brackets) from an array of strings
 * @param strings An @c NSArray of strings
 * @return The same array of strings with text contained in brackets removed from each string.
 */
+(NSArray *)stringsByRemovingComments: (NSArray *)strings;

/*! Tests if a schedule line is a comment (i.e. starts with //).
 * @param line The schedule line string to test.
 * @return @c YES if the line starts with //, else NO.
 */
+(BOOL)lineIsAComment: (NSString *)line;

/*! This is a debugging function that prints the schedule using NSLog
 */
-(void)printSchedule;

@end
