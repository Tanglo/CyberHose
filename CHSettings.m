/*
 * CHSettings.m
 *
 * Created by: Lee Walsh on 06/08/2016.
 * Copyright (c) 2016 Lee David Walsh. All rights reserved.
 * This software is licensed under The MIT License (MIT)
 * See: https://github.com/Tanglo/CyberHose/blob/master/LICENSE.md
 */

#import "CHSettings.h"
#import <syslog.h>

@implementation CHSettings

-(id)init{
	self = [super init];
	if (self) {
		NSString *settingsPath = [[NSString stringWithFormat:@"~/.cyberhose"] stringByExpandingTildeInPath];
		if([[NSFileManager defaultManager] fileExistsAtPath: settingsPath]){
			syslog(LOG_NOTICE, "Found settings file");
			NSError *error;
			NSString *settingsString = [NSString stringWithContentsOfFile: settingsPath encoding: NSUTF8StringEncoding error: &error];
			if(settingsString != nil){
				NSScanner *settingsScanner = [NSScanner scannerWithString: settingsString];
				[settingsScanner scanUpToString: @"schedulePath" intoString: NULL];
				if(![settingsScanner scanString: @"schedulePath" intoString: NULL]){
					NSLog([NSString stringWithFormat: @"Error starting CyberHose: Variable schedulePath is not defined in %@", settingsPath]);
					return nil;
				}
				[settingsScanner scanUpToString: @"=" intoString: NULL];
				if(![settingsScanner scanString: @"=" intoString: NULL]){
					NSLog([NSString stringWithFormat: @"Error starting CyberHose: Variable schedulePath is not defined in %@", settingsPath]);
					return nil;
				}
				[settingsScanner scanUpToString: @"'" intoString: NULL];
				if(![settingsScanner scanString: @"'" intoString: NULL]){
					NSLog([NSString stringWithFormat: @"Error starting CyberHose: Variable schedulePath is not defined in %@", settingsPath]);
					return nil;
				}
				if(![settingsScanner scanUpToString: @"'" intoString: &_schedulePath]){
					NSLog([NSString stringWithFormat: @"Error starting CyberHose: Variable schedulePath is not defined in %@", settingsPath]);
					return nil;
				}
				
				_maxLines = 100;
				[settingsScanner setScanLocation: 0];
				[settingsScanner scanUpToString: @"maxLines" intoString: NULL];
				if([settingsScanner scanString: @"maxLines" intoString: NULL]){
					[settingsScanner scanUpToString: @"=" intoString: NULL];
					if([settingsScanner scanString: @"=" intoString: NULL]){
						NSInteger newMaxLines;
						if([settingsScanner scanInteger: &newMaxLines]){
							_maxLines = newMaxLines;
						}
					}
				}
				
			} else {
				NSLog([error localizedFailureReason]);
				return nil;
			}
			
		} else {
			NSLog(@"Error starting CyberHose: Not settings found at ~/.cyberhose");
			return nil;
		}
		return self;
	}
	return nil;
}

+(CHSettings *)settings{
	return [[[CHSettings alloc] init] autorelease];
}

-(NSString *)schedulePath{
	return _schedulePath;
}

-(NSInteger)maxLines{
	return _maxLines;
}


@end
