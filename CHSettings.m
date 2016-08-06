/*
 * CHSettings.m
 *
 * Created by: Lee Walsh on 17/07/2016.
 * Copyright (c) 2016 Lee David Walsh. All rights reserved.
 * This software is licensed under The MIT License (MIT)
 * See: https://github.com/Tanglo/CyberHose/blob/master/LICENSE.md
 */

#import "CHSettings.h"

@implementation CHSettings

-(id)init{
	self = [super init];
	if (self) {
		NSString *settingsPath = [[NSString stringWithFormat:@"~/.cyberhose"] stringByExpandingTildeInPath];
		NSLog(settingsPath);
		if([[NSFileManager defaultManager] fileExistsAtPath: settingsPath]){
			NSLog(@"Found settings file");
		} else {
			NSLog(@"Error starting CyberHose: Not settings found at ~/.cyberhose");
		}
	}
	return nil;
}

@end
