/*
 * CHSettings.h
 *
 * Created by: Lee Walsh on 06/08/2016.
 * Copyright (c) 2016 Lee David Walsh. All rights reserved.
 * This software is licensed under The MIT License (MIT)
 * See: https://github.com/Tanglo/CyberHose/blob/master/LICENSE.md
 */

#import <Foundation/Foundation.h>

/*!
 @brief A class to load and store the CyberHose settings.
 
 An instance of this class is created when CyberHose starts.  The settings are then loaded from the file ~/.cyberhose.
 */
@interface CHSettings : NSObject {

	/// @brief The path to the schedule file.
	NSString *_schedulePath;
	
	/// @brief The maximum number of lines that can be simultaneously irrigated.
	NSInteger _maxLines;
}

/*! Creates a new autoreleasing instance of @c CHSettings.
 * @return If sucessful, the newly created instance of @c CHSettings, otherwise @c nil.
 */
+(CHSettings *)settings;

/*! Returns the path to the CyberHose schedule file..
 * @return An @c NSString that shows the path to the schedule file.
 */
-(NSString *)schedulePath;

/*! Returns the maximum number of lines that will be simultaneouly irrigated.  If the maximum number of lines are already being irrigated, the current line will be added to a queue.
 * @return The namixmum number of lines that will be simultaneously irrigated.
 */
-(NSInteger)maxLines;

@end
