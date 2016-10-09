/*
 * CHMain.m
 *
 * Created by: Lee Walsh on 17/07/2016.
 * Copyright (c) 2016 Lee David Walsh. All rights reserved.
 * This software is licensed under The MIT License (MIT)
 * See: https://github.com/Tanglo/CyberHose/blob/master/LICENSE.md
 */

#import "CHMain.h"
#import "CHGPIO.h"
#import "CHSettings.h"
#import "CHSchedule.h"
#import "CHStartDaemon.m"
#import "CHScheduleLine.h"

int main(int argc, const char * argv[])
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSLog(@"Starting CyberHose");
	CHSettings *settings = [CHSettings settings];

	CHSchedule *schedule = [CHSchedule scheduleWithPath: [settings schedulePath]];
	startCyberhoseDaemon();
//	[schedule printSchedule];
	
	//Start initial timers
	for(CHScheduleLine* scheduleLine in schedule){
		//[scheduleLine printScheduleLine];
	}
	
	[NSTimer scheduledTimerWithTimeInterval: 30.0 target: [schedule scheduleLineAtIndex: 0] selector: @selector(startIrrigation) userInfo: nil repeats: NO];
	
	//sit and wait for timers
/*	while([[NSRunLoop currentRunLoop] runMode: NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow: 2]]){
		NSLog(@"New runLoop cycle");
	}
*/
/*	while(1){
	
	}
*/
	
/*
	NSLog(@"Making a CHGPIO");
	CHGPIO *testPin = [CHGPIO gpioWithGPIO: 17 AndMode: GPIO_OUTPUT];
	NSLog([NSString stringWithFormat: @"testPin is controlling pin number %d", testPin.gpioNumber]);
	if(testPin.mode == GPIO_INPUT){
		NSLog(@"testPin is an input");
	} else if(testPin.mode == GPIO_OUTPUT){
		NSLog(@"testPint is an output");
	}
	
	NSInteger i;
	for(i=0; i<100; i++){
		testPin.setHigh;
		bcm2835_delay(100);
		testPin.setLow;
		bcm2835_delay(100);
	}
*/
	
	[pool release];
	return 0;
}
