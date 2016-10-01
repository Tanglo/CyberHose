/*
 * CHTime.h
 *
 * Created by: Lee Walsh on 01/10/2016.
 * Copyright (c) 2016 Lee David Walsh. All rights reserved.
 * This software is licensed under The MIT License (MIT)
 * See: https://github.com/Tanglo/CyberHose/blob/master/LICENSE.md
 */

#import <Foundation/Foundation.h>

/*!
 @brief A class to represent 4 digit times.
 
 Instances of this class are are not mutable.
 */
@interface CHTime : NSObject {
	
	NSInteger _theTime;
}

/*! Initialises a @c CHTime object using an @c NSInteger that is within the interval [0,2359].
 * @param newTime An @c NSInteger that represents a 4 digit time.
 * @return If sucessful, an initialised instance of @c CHTime, otherwise @c nil.
 */
-(CHTime *)initWithInteger: (NSInteger)newTime;

/*! Create and initialises a new instance of a @c CHTime object using an @c NSInteger that is in the interval [0,2359].
 * @param newTime An @c NSInteger that represents a 4 digit time.
 * @return If sucessful, an initialised instance of @c CHTime, otherwise @c nil.
 */
+(CHTime *)timeWithInteger: (NSInteger)newTime;

@end
