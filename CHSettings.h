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

@end
