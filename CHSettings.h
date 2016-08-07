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
	NSString *schedulePath;
}

/*! Creates a new autoreleasing instance of @c CHSettings.
 * @return If sucessful, the newly created instance of @c CHSettings, otherwise @c nil.
 */
+(CHSettings *)settings;

/*! Returns the path to the CyberHose schedule file..
 * @return An @c NSString that shows the path to the schedule file.
 */
-(NSString *)schedulePath;

@end
