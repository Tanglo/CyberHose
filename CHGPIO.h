/*
 * CHGPIO.h
 *
 * Created by: Lee Walsh on 17/07/2016.
 * Copyright (c) 2016 Lee David Walsh. All rights reserved.
 * This software is licensed under The MIT License (MIT)
 * See: https://github.com/Tanglo/CyberHose/blob/master/LICENSE.md
 */

#import <Foundation/Foundation.h>
#import <bcm2835.h>

#define GPIO_INPUT 1
#define GPIO_OUTPUT 2 

/*!
 @brief A wrapper class for the pigpio library for controlling raspberry pi GPIO pins
 
 An instance of this object will control one GPIO pin of a reaspberry pi.  Whether the pin is an input or output is set during initialisation.
 */
@interface CHGPIO : NSObject {

	/// @brief The number of the GPIO on the raspberry pi that is controlled by this object.  Can only be set during initialisation
	NSInteger gpioNumber;
	
	/// @brief Sets whether the GPIO is an input or output.  Can only be set during initialisation.
	NSInteger mode;
}

/*! Intitiates a new @c CHGPIO object to operate the specified GPIO number in the specified mode (input/output).
 * @param gpioPin An integer that sets which GPIO of the raspberry pi will be controlled by this object.
 * @param mode The mode the initialised GPIO will be operated in.  Should be set to @c GPIO_INPUT or @c GPIO_OUTPUT.
 * @return A @c CHGPIO instance that has been initialised with the specified @c gpio number and @c mode.
 */
-(CHGPIO *)initWithGPIO: (NSInteger)number AndMode: (NSInteger)newMode;

/*! Creates and intitiates a new @c CHGPIO object to operate the specified GPIO number in the specified mode (input/output).
 * @param gpioPin An integer that sets which GPIO  of the raspberry pi will by this object.
 * @param mode The mode the initialised pin will be operated in.  Should be set to @c GPIO_INPUT or @c GPIO_OUTPUT.
 * @return A @c CHGPIO instance that has been initialised with the specified @c gpio number and @c mode.
 */
+(CHGPIO *)gpioWithGPIO: (NSInteger)number AndMode: (NSInteger)newMode;

//Getters

/*! Gets the number of the GPIO on the raspberry pi that is controlled by this instance.
 * @return The number of the raspberry pi GPIO that is controlled by this instance.
 */
 -(NSInteger)gpioNumber;
 
/*! Gets the mode of operation of the GPIO on the raspberry pi that is controlled by this instance.
 * @return An integer representation of the mode of operation that should be equal to either @c GPIO_INPUT or @c GPIO_OUTPUT.
 */
-(NSInteger)mode;
 
//Level setters
 
/*! Sets the GPIO to be high
 */
-(void)setHigh;
 
/*! Sets the GPIO to be low
 */
-(void)setLow;

@end
