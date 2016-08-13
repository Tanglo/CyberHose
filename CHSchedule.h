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
 */
@interface CHSchedule : NSObject {


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

@end
