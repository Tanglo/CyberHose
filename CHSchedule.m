/*
 * CHSchedule.m
 *
 * Created by: Lee Walsh on 13/08/2016.
 * Copyright (c) 2016 Lee David Walsh. All rights reserved.
 * This software is licensed under The MIT License (MIT)
 * See: https://github.com/Tanglo/CyberHose/blob/master/LICENSE.md
 */

#import "CHSchedule.h"

@interface CHSchedule ()

-(void)decodeLineStrings: (NSArray *)lines;

@end

@implementation CHSchedule

-(id)init{
	NSLog(@"Error: use initWithPath: instead of init");
	return nil;
}

-(id)initWithPath: (NSString *)path{
	self = [super init];
	if (self) {
		NSString *fullPath = [path stringByExpandingTildeInPath];
		if([[NSFileManager defaultManager] fileExistsAtPath: fullPath]){
			NSLog([NSString stringWithFormat: @"Found schedule file at %@", fullPath]);
			NSError *error;
			NSString *scheduleString = [NSString stringWithContentsOfFile: fullPath encoding: NSUTF8StringEncoding error: &error];
			if(fullPath != nil){
				scheduleString = [scheduleString stringByReplacingOccurrencesOfString: @" " withString: @""];
				NSArray *lineStrings = [scheduleString componentsSeparatedByString: @"\n"];
				lineStrings = [CHSchedule scheduleLinesByRemovingCommentsAndBlankLinesFrom: lineStrings];
				[self decodeLineStrings: lineStrings];
			}
		return self;
		}
	}
	return nil;
}

-(void)decodeLineStrings:(NSArray *)lines{
	NSArray *scheduleHeaders;
	scheduleHeaders = [[lines objectAtIndex: 0] componentsSeparatedByString: @"|"];
	scheduleHeaders = [CHSchedule stringsByRemovingComments: scheduleHeaders];
	
}

+(CHSchedule *)scheduleWithPath: (NSString *) path{
	return [[[CHSchedule alloc] initWithPath: path] autorelease];
}

+(NSArray *)scheduleLinesByRemovingCommentsAndBlankLinesFrom: (NSArray *)lines{
	NSMutableArray *newLines = [NSMutableArray array];
	for(NSString *currLine in lines){
		if(![currLine isEqualToString: @""] && ![CHSchedule lineIsAComment: currLine]){
			[newLines addObject: currLine];
		}
	}
	return [NSArray arrayWithArray: newLines];
}

+(NSArray *)stringsByRemovingComments: (NSArray *)strings{
	NSMutableArray *newStrings = [NSMutableArray array];
	for(NSString *currString in strings){
		NSString *newString;
		NSScanner *scanner = [NSScanner scannerWithString: currString];
		[scanner scanUpToString: @"(" intoString: &newString];
		[newStrings addObject: newString];
	}
	return [NSArray arrayWithArray: newStrings];
}

+(BOOL)lineIsAComment: (NSString *)line{
	if([line characterAtIndex: 0] == '/' && [line characterAtIndex: 1] == '/'){
		return YES;
	}
	return NO;
}

@end
