/*
 * CHEvent.h
 *
 * Created by: Lee Walsh on 22/10/2016.
 * Copyright (c) 2016 Lee David Walsh. All rights reserved.
 * This software is licensed under The MIT License (MIT)
 * See: https://github.com/Tanglo/CyberHose/blob/master/LICENSE.md
 */

#import <Foundation/Foundation.h>

#define CHActionStartIrrigation @"CHActionStartIrrigation"
#define CHActionStopIrrigation @"CHActionStopIrrigation"

@class CHScheduleLine;

/*!
 @brief Represents a cyberhose timing event
 
 The class is used to keep lists of events for polling.  A @c CHEvent object includes an @c NSDate object which is created using the schedule and is used by the main polling loop to determine if the event should be triggered.
 */
@interface CHEvent : NSObject {
	
	/// @brief The time that the event should be triggered.
	NSDate *_triggerTime;
	
	/// @brief The scheduleLine that this event was created from.
	CHScheduleLine *_line;
	
	/// @brief The name of the action that should be taken when this evvent triggers.
	NSString* _action;
}

/*! Initialises a @c CHEvent object.
 * @param triggerTime The time that this event should be triggered.
 * @param line The scheduleLine that this event was created from.
 * @param action The name of the action to be taken when this event is triggered.
 * @return If sucessful, an initialised instance of @c CHEvent, otherwise @c nil.
 */
-(CHEvent *)initWithTriggerTime: (NSDate *)triggerTime Line: (CHScheduleLine *)line AndAction: (NSString *)action;

/*! Create and initialises a @c CHEvent object.
 * @param triggerTime The time that this event should be triggered.
 * @param line The scheduleLine that this event was created from.
 * @param action The name of the action to be taken when this event is triggered.
 * @return If sucessful, an initialised instance of @c CHEvent, otherwise @c nil.
 */
+(CHEvent *)eventWithTriggerTime: (NSDate *)triggerTime Line: (CHScheduleLine *)line AndAction: (NSString *)action;

/*! Gets the triggerTime for this event.
 * @return The triggerTime.
 */
-(NSDate *)triggerTime;

/*! Gets the scheduleLine for this event.
 * @return The sceduleLine.
 */
-(CHScheduleLine *)line;

/*! Gets the name of the action to be taken when this event triggers.
 * @return The action.
 */
-(NSString *)action;

@end
