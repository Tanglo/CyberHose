/*
 * CHGPIO.m
 *
 * Created by: Lee Walsh on 17/07/2016.
 * Copyright (c) 2016 Lee David Walsh. All rights reserved.
 * This software is licensed under The MIT License (MIT)
 * See: https://github.com/Tanglo/CyberHose/blob/master/LICENSE.md
 */

#import "CHGPIO.h"

@implementation CHGPIO

-(id)init{
	self = [super init];
	if (self) {
		NSLog(@"Error: use initWithType: instead of init");
	}
	return nil;
}

-(CHGPIO *)initWithGPIO: (NSInteger)newGpioNumber AndMode: (NSInteger)newMode{
	if (bcm2835_init()){
		self = [super init];
		if (self){
			gpioNumber = newGpioNumber;
			mode = newMode;
			
			if(mode == GPIO_OUTPUT){
				bcm2835_gpio_fsel(gpioNumber, BCM2835_GPIO_FSEL_OUTP);
			}
		}
		return self;
	}
	NSLog(@"Error: Could not initialise the pi GPIO");
	return nil;
}

+(CHGPIO *)gpioWithGPIO: (NSInteger)number AndMode: (NSInteger)newMode{
	CHGPIO *gpio = [[CHGPIO alloc] initWithGPIO: number AndMode: newMode];
	[gpio autorelease];
	return gpio;
}
	
//Getters


 -(NSInteger)gpioNumber{
	return gpioNumber;
}
 
 -(NSInteger)mode{
	return mode;
}

//Level setters

-(void)setHigh{
	bcm2835_gpio_write(gpioNumber, HIGH);
}
 

-(void)setLow{
	bcm2835_gpio_write(gpioNumber, LOW);
}

@end
